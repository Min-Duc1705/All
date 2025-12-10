import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:magic_enlish/providers/vocabulary/vocabulary_provider.dart';
import 'package:magic_enlish/data/models/vocabulary/Vocabulary.dart';

class FillBlankScreen extends StatefulWidget {
  const FillBlankScreen({super.key});

  @override
  State<FillBlankScreen> createState() => _FillBlankScreenState();
}

class _FillBlankScreenState extends State<FillBlankScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isChecked = false;
  List<Vocabulary> _exercises = [];
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _loadExercises() async {
    final provider = Provider.of<VocabularyProvider>(context, listen: false);
    await provider.loadVocabularies();

    if (provider.vocabularies.isEmpty) return;

    setState(() {
      _exercises =
          (provider.vocabularies.where((v) => v.example.isNotEmpty).toList()
                ..shuffle())
              .take(10)
              .toList();
    });
  }

  void _checkAnswer() {
    if (_answerController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter an answer', style: GoogleFonts.lexend()),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isChecked = true;
      final userAnswer = _answerController.text.trim().toLowerCase();
      final correctAnswer = _exercises[_currentQuestionIndex].word
          .toLowerCase();

      if (userAnswer == correctAnswer) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _exercises.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isChecked = false;
        _answerController.clear();
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Exercise Complete! 🎉',
          style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your Score',
              style: GoogleFonts.lexend(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              '$_score / ${_exercises.length}',
              style: GoogleFonts.lexend(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00C49A),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Back', style: GoogleFonts.lexend()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
                _isChecked = false;
                _answerController.clear();
              });
              _loadExercises();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C49A),
            ),
            child: Text(
              'Try Again',
              style: GoogleFonts.lexend(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  String _getSentenceWithBlank(String example, String word) {
    // Replace the word with blank (_____)
    final regex = RegExp(word, caseSensitive: false);
    return example.replaceFirst(regex, '_____');
  }

  @override
  Widget build(BuildContext context) {
    const secondary = Color(0xFF00C49A);

    if (_exercises.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Fill in the Blanks', style: GoogleFonts.lexend()),
          backgroundColor: secondary,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final currentVocab = _exercises[_currentQuestionIndex];
    final sentenceWithBlank = _getSentenceWithBlank(
      currentVocab.example,
      currentVocab.word,
    );
    final userAnswer = _answerController.text.trim().toLowerCase();
    final correctAnswer = currentVocab.word.toLowerCase();
    final isCorrect = userAnswer == correctAnswer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fill in the Blanks', style: GoogleFonts.lexend()),
        backgroundColor: secondary,
        foregroundColor: Colors.white,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                'Score: $_score/${_exercises.length}',
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _exercises.length,
              backgroundColor: Colors.grey[300],
              color: secondary,
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_exercises.length}',
              style: GoogleFonts.lexend(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),

            // Instruction
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: secondary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Fill in the blank with the correct word',
                      style: GoogleFonts.lexend(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Sentence with blank
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Text(
                sentenceWithBlank,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  height: 1.6,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),

            // Answer Input
            TextField(
              controller: _answerController,
              enabled: !_isChecked,
              decoration: InputDecoration(
                labelText: 'Your Answer',
                hintText: 'Type the missing word here',
                prefixIcon: Icon(Icons.edit, color: secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: secondary, width: 2),
                ),
              ),
              style: GoogleFonts.lexend(fontSize: 16),
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
            ),

            const SizedBox(height: 24),

            // Result Display
            if (_isChecked) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isCorrect ? Colors.green : Colors.red,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? Colors.green : Colors.red,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            isCorrect ? 'Correct! 🎉' : 'Incorrect',
                            style: GoogleFonts.lexend(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (!isCorrect) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Correct answer: ${currentVocab.word}',
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Text(
                      currentVocab.meaning,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Buttons
            if (!_isChecked)
              ElevatedButton(
                onPressed: _checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Check Answer',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            else
              ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentQuestionIndex < _exercises.length - 1
                      ? 'Next Question'
                      : 'Finish Exercise',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
