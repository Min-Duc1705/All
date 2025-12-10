package vn.project.magic_english.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;

import java.math.BigDecimal;
import java.math.RoundingMode;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.project.magic_english.model.*;
import vn.project.magic_english.model.request.GenerateIELTSTestRequest;
import vn.project.magic_english.model.request.StartIELTSTestRequest;
import vn.project.magic_english.model.request.SubmitIELTSTestRequest;
import vn.project.magic_english.model.response.*;
import vn.project.magic_english.repository.*;
import vn.project.magic_english.utils.SecurityUtil;
import vn.project.magic_english.utils.error.IdInvalidException;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class IELTSService {

    private final ChatClient chatClient;
    private final IELTSTestRepository testRepository;
    private final IELTSTestHistoryRepository historyRepository;
    private final IELTSUserAnswerRepository userAnswerRepository;
    private final UserRepository userRepository;
    private final ObjectMapper objectMapper;
    private final TextToSpeechService textToSpeechService;

    /**
     * Generate IELTS test using Gemini AI
     * Always generates a new test to avoid caching issues
     */
    @Transactional
    public IELTSTestResponse generateTest(GenerateIELTSTestRequest request) throws JsonProcessingException {
        // Always generate new test using AI (no caching)
        String aiPrompt = buildAIPrompt(request);
        String aiResponse = generateWithAI(aiPrompt);

        // Parse AI response and save to database
        IELTSTest test = parseAndSaveTest(aiResponse, request);

        return convertToResponse(test, false);
    }

    /**
     * Start a test session
     */
    @Transactional
    public IELTSTestHistoryResponse startTest(StartIELTSTestRequest request) throws IdInvalidException {
        String email = SecurityUtil.getCurrentUserLogin().orElseThrow(
                () -> new IdInvalidException("User not authenticated"));
        User user = userRepository.findByEmail(email);

        IELTSTest test = testRepository.findById(request.getTestId())
                .orElseThrow(() -> new IdInvalidException("Test not found with ID: " + request.getTestId()));

        IELTSTestHistory history = new IELTSTestHistory();
        history.setUser(user);
        history.setTest(test);
        history.setStatus("in_progress");
        history.setStartedAt(Instant.now());
        history.setTotalAnswers(test.getTotalQuestions());

        historyRepository.save(history);

        return convertToHistoryResponse(history);
    }

    /**
     * Submit test and calculate score
     */
    @Transactional
    public IELTSTestResultResponse submitTest(SubmitIELTSTestRequest request) throws IdInvalidException {
        IELTSTestHistory history = historyRepository.findById(request.getHistoryId())
                .orElseThrow(() -> new IdInvalidException("Test history not found"));

        if (!"in_progress".equals(history.getStatus())) {
            throw new IdInvalidException("Test is already completed");
        }

        int correctAnswers = 0;
        List<IELTSQuestionResultResponse> questionResults = new ArrayList<>();

        // Process each answer
        for (SubmitIELTSTestRequest.UserAnswerRequest answerReq : request.getAnswers()) {
            IELTSQuestion question = history.getTest().getQuestions().stream()
                    .filter(q -> q.getId().equals(answerReq.getQuestionId()))
                    .findFirst()
                    .orElseThrow(() -> new IdInvalidException("Question not found"));

            IELTSAnswer correctAnswer = question.getAnswers().stream()
                    .filter(IELTSAnswer::getIsCorrect)
                    .findFirst()
                    .orElse(null);

            boolean isCorrect = false;
            String userAnswerText = "";

            if (answerReq.getSelectedAnswerId() != null) {
                // Multiple choice
                IELTSAnswer selectedAnswer = question.getAnswers().stream()
                        .filter(a -> a.getId().equals(answerReq.getSelectedAnswerId()))
                        .findFirst()
                        .orElse(null);

                if (selectedAnswer != null) {
                    isCorrect = selectedAnswer.getIsCorrect();
                    userAnswerText = selectedAnswer.getAnswerOption();
                }
            }

            if (isCorrect) {
                correctAnswers++;
            }

            // Save user answer
            IELTSUserAnswer userAnswer = new IELTSUserAnswer();
            userAnswer.setHistory(history);
            userAnswer.setQuestion(question);
            if (answerReq.getSelectedAnswerId() != null) {
                IELTSAnswer selectedAnswer = question.getAnswers().stream()
                        .filter(a -> a.getId().equals(answerReq.getSelectedAnswerId()))
                        .findFirst()
                        .orElse(null);
                userAnswer.setSelectedAnswer(selectedAnswer);
            }
            userAnswer.setUserAnswerText(answerReq.getAnswerText());
            userAnswer.setIsCorrect(isCorrect);
            userAnswerRepository.save(userAnswer);

            // Add to results
            IELTSQuestionResultResponse resultResponse = new IELTSQuestionResultResponse();
            resultResponse.setQuestionId(question.getId());
            resultResponse.setQuestionNumber(question.getQuestionNumber());
            resultResponse.setQuestionText(question.getQuestionText());
            resultResponse.setUserAnswer(userAnswerText);
            resultResponse.setCorrectAnswer(correctAnswer != null ? correctAnswer.getAnswerOption() : "");
            resultResponse.setIsCorrect(isCorrect);
            resultResponse.setExplanation(correctAnswer != null ? correctAnswer.getExplanation() : "");
            questionResults.add(resultResponse);
        }

        // Calculate score (IELTS band score approximation)
        double percentage = (double) correctAnswers / history.getTotalAnswers();
        BigDecimal score = calculateIELTSBandScore(percentage);

        // Update history
        history.setCorrectAnswers(correctAnswers);
        history.setScore(score);
        history.setStatus("completed");
        history.setCompletedAt(Instant.now());
        history.setTimeSpentSeconds(request.getTimeSpentSeconds());
        historyRepository.save(history);

        // Build result response
        IELTSTestResultResponse result = new IELTSTestResultResponse();
        result.setHistoryId(history.getId());
        result.setScore(score.doubleValue());
        result.setCorrectAnswers(correctAnswers);
        result.setTotalQuestions(history.getTotalAnswers());
        result.setTimeSpentSeconds(request.getTimeSpentSeconds());
        result.setQuestionResults(questionResults);

        return result;
    }

    /**
     * Get user test history
     */
    public List<IELTSTestHistoryResponse> getUserHistory() throws IdInvalidException {
        String email = SecurityUtil.getCurrentUserLogin().orElseThrow(
                () -> new IdInvalidException("User not authenticated"));
        User user = userRepository.findByEmail(email);

        List<IELTSTestHistory> histories = historyRepository.findByUserIdOrderByCreatedAtDesc(user.getId());
        return histories.stream()
                .map(this::convertToHistoryResponse)
                .collect(Collectors.toList());
    }

    /**
     * Get test by ID with questions
     */
    public IELTSTestResponse getTestById(Long testId) throws IdInvalidException {
        IELTSTest test = testRepository.findById(testId)
                .orElseThrow(() -> new IdInvalidException("Test not found"));
        return convertToResponse(test, false);
    }

    // ========== Private Helper Methods ==========

    private String buildAIPrompt(GenerateIELTSTestRequest request) {
        int numQuestions = request.getDifficulty().equals("Easy") ? 10
                : request.getDifficulty().equals("Medium") ? 15 : 20;

        // Build prompt directly without PromptTemplate to avoid placeholder conflicts
        String prompt = String.format(
                """
                        Generate an IELTS %s test with %s level and %s difficulty.

                        Create %d multiple choice questions. Each question should have 4 options (A, B, C, D) with only ONE correct answer.

                        For Reading skill: Include a reading passage and questions about it.
                        For Listening skill: Create a natural English conversation or monologue script in the "passage" field.
                        The passage should be approximately 150-200 words (around 900-1200 characters) that will be converted to audio.
                        Make it sound like natural spoken English. Include speaker names for conversations (e.g., "Sarah:", "John:").
                        Examples for Listening:
                        - A conversation between two people discussing a topic (with speaker labels)
                        - A monologue about a topic (like a news report, announcement, or lecture)
                        - A dialogue in a real-life situation (restaurant, airport, office, etc.)

                        For Writing/Speaking: Create grammar and vocabulary questions (no passage needed).

                        IMPORTANT: For the correct answer, provide a detailed explanation (2-3 sentences) explaining WHY it is correct.
                        For incorrect answers, provide brief explanation (1 sentence) explaining WHY they are wrong.

                        Return ONLY a valid JSON object in this exact format (no markdown, no extra text):
                        {
                          "title": "IELTS %s %s Test - %s",
                          "durationMinutes": 60,
                          "questions": [
                            {
                              "questionNumber": 1,
                              "questionText": "Question text here",
                              "questionType": "multiple_choice",
                              "passage": "For Listening: Natural spoken English script (150-200 words with speaker labels). For Reading: Reading passage. For others: null or empty.",
                              "answers": [
                                {"answerOption": "A", "answerText": "Option A text", "isCorrect": false, "explanation": "This is incorrect because..."},
                                {"answerOption": "B", "answerText": "Option B text", "isCorrect": true, "explanation": "This is correct because... The speaker mentioned that..."},
                                {"answerOption": "C", "answerText": "Option C text", "isCorrect": false, "explanation": "This is wrong because..."},
                                {"answerOption": "D", "answerText": "Option D text", "isCorrect": false, "explanation": "This was not mentioned."}
                              ]
                            }
                          ]
                        }
                        """,
                request.getSkill(),
                request.getLevel(),
                request.getDifficulty(),
                numQuestions,
                request.getLevel(),
                request.getSkill(),
                request.getDifficulty());

        return prompt;
    }

    private String generateWithAI(String prompt) {
        try {
            String response = chatClient.prompt()
                    .user(prompt)
                    .call()
                    .content();

            log.info("AI Response: {}", response);
            return response;
        } catch (Exception e) {
            log.error("Error generating test with AI", e);
            throw new RuntimeException("Failed to generate test: " + e.getMessage());
        }
    }

    private IELTSTest parseAndSaveTest(String aiResponse, GenerateIELTSTestRequest request)
            throws JsonProcessingException {
        // Clean up response (remove markdown if present)
        String cleanedResponse = aiResponse.trim();
        if (cleanedResponse.startsWith("```json")) {
            cleanedResponse = cleanedResponse.substring(7);
        }
        if (cleanedResponse.startsWith("```")) {
            cleanedResponse = cleanedResponse.substring(3);
        }
        if (cleanedResponse.endsWith("```")) {
            cleanedResponse = cleanedResponse.substring(0, cleanedResponse.length() - 3);
        }
        cleanedResponse = cleanedResponse.trim();

        JsonNode rootNode = objectMapper.readTree(cleanedResponse);

        IELTSTest test = new IELTSTest();
        test.setSkill(request.getSkill());
        test.setLevel(request.getLevel());
        test.setDifficulty(request.getDifficulty());
        test.setTitle(rootNode.get("title").asText());
        test.setDurationMinutes(rootNode.get("durationMinutes").asInt());
        test.setTotalQuestions(rootNode.get("questions").size());

        // Parse questions
        JsonNode questionsNode = rootNode.get("questions");
        for (JsonNode questionNode : questionsNode) {
            IELTSQuestion question = new IELTSQuestion();
            question.setTest(test);
            question.setQuestionNumber(questionNode.get("questionNumber").asInt());
            question.setQuestionText(questionNode.get("questionText").asText());
            question.setQuestionType(
                    questionNode.has("questionType") ? questionNode.get("questionType").asText() : "multiple_choice");

            // Handle passage and audio for Listening tests
            String passage = null;
            if (questionNode.has("passage") && !questionNode.get("passage").isNull()) {
                passage = questionNode.get("passage").asText();
                question.setPassage(passage);
            }

            // Generate audio URL for Listening tests
            if ("Listening".equalsIgnoreCase(test.getSkill())) {
                // Use passage if available, otherwise use question text
                String textToConvert = (passage != null && !passage.isEmpty())
                        ? passage
                        : question.getQuestionText();

                String audioUrl = textToSpeechService.generateWithResponsiveVoice(textToConvert);
                question.setAudioUrl(audioUrl);
                log.info("Generated audio URL for Listening question {}: {}", question.getQuestionNumber(), audioUrl);
            }

            // Parse answers
            JsonNode answersNode = questionNode.get("answers");
            for (JsonNode answerNode : answersNode) {
                IELTSAnswer answer = new IELTSAnswer();
                answer.setQuestion(question);
                answer.setAnswerOption(answerNode.get("answerOption").asText());
                answer.setAnswerText(answerNode.get("answerText").asText());
                answer.setIsCorrect(answerNode.get("isCorrect").asBoolean());
                if (answerNode.has("explanation") && !answerNode.get("explanation").isNull()) {
                    answer.setExplanation(answerNode.get("explanation").asText());
                }
                question.getAnswers().add(answer);
            }

            test.getQuestions().add(question);
        }

        return testRepository.save(test);
    }

    private BigDecimal calculateIELTSBandScore(double percentage) {
        // Simplified IELTS band score calculation
        double score;
        if (percentage >= 0.90)
            score = 9.0;
        else if (percentage >= 0.82)
            score = 8.5;
        else if (percentage >= 0.75)
            score = 8.0;
        else if (percentage >= 0.67)
            score = 7.5;
        else if (percentage >= 0.60)
            score = 7.0;
        else if (percentage >= 0.52)
            score = 6.5;
        else if (percentage >= 0.45)
            score = 6.0;
        else if (percentage >= 0.37)
            score = 5.5;
        else if (percentage >= 0.30)
            score = 5.0;
        else if (percentage >= 0.22)
            score = 4.5;
        else
            score = 4.0;

        return BigDecimal.valueOf(score).setScale(1, RoundingMode.HALF_UP);
    }

    private IELTSTestResponse convertToResponse(IELTSTest test, boolean includeCorrectAnswers) {
        IELTSTestResponse response = new IELTSTestResponse();
        response.setId(test.getId());
        response.setSkill(test.getSkill());
        response.setLevel(test.getLevel());
        response.setDifficulty(test.getDifficulty());
        response.setTitle(test.getTitle());
        response.setDurationMinutes(test.getDurationMinutes());
        response.setTotalQuestions(test.getTotalQuestions());

        List<IELTSQuestionResponse> questions = test.getQuestions().stream()
                .map(q -> {
                    IELTSQuestionResponse qr = new IELTSQuestionResponse();
                    qr.setId(q.getId());
                    qr.setQuestionNumber(q.getQuestionNumber());
                    qr.setQuestionText(q.getQuestionText());
                    qr.setQuestionType(q.getQuestionType());
                    qr.setPassage(q.getPassage());
                    qr.setAudioUrl(q.getAudioUrl());

                    List<IELTSAnswerResponse> answers = q.getAnswers().stream()
                            .map(a -> {
                                IELTSAnswerResponse ar = new IELTSAnswerResponse();
                                ar.setId(a.getId());
                                ar.setAnswerOption(a.getAnswerOption());
                                ar.setAnswerText(a.getAnswerText());
                                ar.setIsCorrect(includeCorrectAnswers ? a.getIsCorrect() : null);
                                ar.setExplanation(includeCorrectAnswers ? a.getExplanation() : null);
                                return ar;
                            })
                            .collect(Collectors.toList());
                    qr.setAnswers(answers);
                    return qr;
                })
                .collect(Collectors.toList());

        response.setQuestions(questions);
        return response;
    }

    private IELTSTestHistoryResponse convertToHistoryResponse(IELTSTestHistory history) {
        IELTSTestHistoryResponse response = new IELTSTestHistoryResponse();
        response.setId(history.getId());
        response.setTestId(history.getTest().getId());
        response.setTestTitle(history.getTest().getTitle());
        response.setSkill(history.getTest().getSkill());
        response.setLevel(history.getTest().getLevel());
        response.setDifficulty(history.getTest().getDifficulty());
        response.setStartedAt(history.getStartedAt());
        response.setCompletedAt(history.getCompletedAt());
        response.setScore(history.getScore() != null ? history.getScore().doubleValue() : null);
        response.setCorrectAnswers(history.getCorrectAnswers());
        response.setTotalAnswers(history.getTotalAnswers());
        response.setStatus(history.getStatus());
        response.setTimeSpentSeconds(history.getTimeSpentSeconds());
        return response;
    }
}
