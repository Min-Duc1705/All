class IELTSTest {
  final int id;
  final String skill;
  final String level;
  final String difficulty;
  final String title;
  final int durationMinutes;
  final int totalQuestions;
  final List<IELTSQuestion> questions;

  IELTSTest({
    required this.id,
    required this.skill,
    required this.level,
    required this.difficulty,
    required this.title,
    required this.durationMinutes,
    required this.totalQuestions,
    required this.questions,
  });

  factory IELTSTest.fromJson(Map<String, dynamic> json) {
    return IELTSTest(
      id: json['id'] as int,
      skill: json['skill'] as String,
      level: json['level'] as String,
      difficulty: json['difficulty'] as String,
      title: json['title'] as String,
      durationMinutes: json['durationMinutes'] as int,
      totalQuestions: json['totalQuestions'] as int,
      questions: (json['questions'] as List<dynamic>)
          .map((q) => IELTSQuestion.fromJson(q as Map<String, dynamic>))
          .toList(),
    );
  }
}

class IELTSQuestion {
  final int id;
  final int questionNumber;
  final String questionText;
  final String? questionType;
  final String? passage;
  final String? audioUrl;
  final List<IELTSAnswer> answers;

  IELTSQuestion({
    required this.id,
    required this.questionNumber,
    required this.questionText,
    this.questionType,
    this.passage,
    this.audioUrl,
    required this.answers,
  });

  factory IELTSQuestion.fromJson(Map<String, dynamic> json) {
    return IELTSQuestion(
      id: json['id'] as int,
      questionNumber: json['questionNumber'] as int,
      questionText: json['questionText'] as String,
      questionType: json['questionType'] as String?,
      passage: json['passage'] as String?,
      audioUrl: json['audioUrl'] as String?,
      answers: (json['answers'] as List<dynamic>)
          .map((a) => IELTSAnswer.fromJson(a as Map<String, dynamic>))
          .toList(),
    );
  }
}

class IELTSAnswer {
  final int id;
  final String answerOption;
  final String answerText;
  final bool? isCorrect;
  final String? explanation;

  IELTSAnswer({
    required this.id,
    required this.answerOption,
    required this.answerText,
    this.isCorrect,
    this.explanation,
  });

  factory IELTSAnswer.fromJson(Map<String, dynamic> json) {
    return IELTSAnswer(
      id: json['id'] as int,
      answerOption: json['answerOption'] as String,
      answerText: json['answerText'] as String,
      isCorrect: json['isCorrect'] as bool?,
      explanation: json['explanation'] as String?,
    );
  }
}

class IELTSTestHistory {
  final int id;
  final int testId;
  final String testTitle;
  final String skill;
  final String level;
  final String difficulty;
  final DateTime startedAt;
  final DateTime? completedAt;
  final double? score;
  final int correctAnswers;
  final int totalAnswers;
  final String status;
  final int? timeSpentSeconds;

  IELTSTestHistory({
    required this.id,
    required this.testId,
    required this.testTitle,
    required this.skill,
    required this.level,
    required this.difficulty,
    required this.startedAt,
    this.completedAt,
    this.score,
    required this.correctAnswers,
    required this.totalAnswers,
    required this.status,
    this.timeSpentSeconds,
  });

  factory IELTSTestHistory.fromJson(Map<String, dynamic> json) {
    return IELTSTestHistory(
      id: json['id'] as int,
      testId: json['testId'] as int,
      testTitle: json['testTitle'] as String,
      skill: json['skill'] as String,
      level: json['level'] as String,
      difficulty: json['difficulty'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      score: json['score'] != null ? (json['score'] as num).toDouble() : null,
      correctAnswers: json['correctAnswers'] as int,
      totalAnswers: json['totalAnswers'] as int,
      status: json['status'] as String,
      timeSpentSeconds: json['timeSpentSeconds'] as int?,
    );
  }
}

class IELTSTestResult {
  final int historyId;
  final double score;
  final int correctAnswers;
  final int totalQuestions;
  final int timeSpentSeconds;
  final List<IELTSQuestionResult> questionResults;

  IELTSTestResult({
    required this.historyId,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeSpentSeconds,
    required this.questionResults,
  });

  factory IELTSTestResult.fromJson(Map<String, dynamic> json) {
    return IELTSTestResult(
      historyId: json['historyId'] as int,
      score: (json['score'] as num).toDouble(),
      correctAnswers: json['correctAnswers'] as int,
      totalQuestions: json['totalQuestions'] as int,
      timeSpentSeconds: json['timeSpentSeconds'] as int,
      questionResults: (json['questionResults'] as List<dynamic>)
          .map((r) => IELTSQuestionResult.fromJson(r as Map<String, dynamic>))
          .toList(),
    );
  }
}

class IELTSQuestionResult {
  final int questionId;
  final int questionNumber;
  final String questionText;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final String? explanation;

  IELTSQuestionResult({
    required this.questionId,
    required this.questionNumber,
    required this.questionText,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    this.explanation,
  });

  factory IELTSQuestionResult.fromJson(Map<String, dynamic> json) {
    return IELTSQuestionResult(
      questionId: json['questionId'] as int,
      questionNumber: json['questionNumber'] as int,
      questionText: json['questionText'] as String,
      userAnswer: json['userAnswer'] as String,
      correctAnswer: json['correctAnswer'] as String,
      isCorrect: json['isCorrect'] as bool,
      explanation: json['explanation'] as String?,
    );
  }
}
