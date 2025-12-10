import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:magic_enlish/providers/vocabulary/vocabulary_provider.dart';
import 'package:magic_enlish/data/models/vocabulary/Vocabulary.dart';

class ListeningPracticeScreen extends StatefulWidget {
  const ListeningPracticeScreen({super.key});

  @override
  State<ListeningPracticeScreen> createState() =>
      _ListeningPracticeScreenState();
}

class _ListeningPracticeScreenState extends State<ListeningPracticeScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isChecked = false;
  bool _isPlaying = false;
  List<Vocabulary> _exercises = [];
  final TextEditingController _answerController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  @override
  void dispose() {
    _answerController.dispose();
    _audioPlayer.stop();
    _audioPlayer.release();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadExercises() async {
    final provider = Provider.of<VocabularyProvider>(context, listen: false);
    await provider.loadVocabularies();

    if (provider.vocabularies.isEmpty) return;

    setState(() {
      _exercises =
          (provider.vocabularies.where((v) => v.audioUrl.isNotEmpty).toList()
                ..shuffle())
              .take(10)
              .toList();
    });
  }

  Future<void> _playAudio() async {
    if (_exercises.isEmpty) return;

    final currentVocab = _exercises[_currentQuestionIndex];
    if (currentVocab.audioUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No audio available', style: GoogleFonts.lexend()),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isPlaying = true);

    try {
      await _audioPlayer.play(UrlSource(currentVocab.audioUrl));
      _audioPlayer.onPlayerComplete.listen((_) {
        if (mounted) {
          setState(() => _isPlaying = false);
        }
      });
    } catch (e) {
      print('Error playing audio: $e');
      if (mounted) {
        setState(() => _isPlaying = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to play audio', style: GoogleFonts.lexend()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _checkAnswer() {
    if (_answerController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter what you heard',
            style: GoogleFonts.lexend(),
          ),
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
          'Listening Practice Complete! 🎧',
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
                color: const Color(0xFFFF6B6B),
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
              backgroundColor: const Color(0xFFFF6B6B),
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

  @override
  Widget build(BuildContext context) {
    const practiceColor = Color(0xFFFF6B6B);

    if (_exercises.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Listening Practice', style: GoogleFonts.lexend()),
          backgroundColor: practiceColor,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final currentVocab = _exercises[_currentQuestionIndex];
    final userAnswer = _answerController.text.trim().toLowerCase();
    final correctAnswer = currentVocab.word.toLowerCase();
    final isCorrect = userAnswer == correctAnswer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Listening Practice', style: GoogleFonts.lexend()),
        backgroundColor: practiceColor,
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
              color: practiceColor,
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
                color: practiceColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.headphones, color: practiceColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Listen carefully and type what you hear',
                      style: GoogleFonts.lexend(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Audio Player
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _isChecked ? null : _playAudio,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            practiceColor,
                            practiceColor.withOpacity(0.7),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: practiceColor.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isPlaying ? Icons.volume_up : Icons.play_arrow,
                        color: Colors.white,
                        size: 56,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _isPlaying ? 'Playing...' : 'Tap to play audio',
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Answer Input
            TextField(
              controller: _answerController,
              enabled: !_isChecked,
              decoration: InputDecoration(
                labelText: 'What did you hear?',
                hintText: 'Type the word here',
                prefixIcon: Icon(Icons.edit, color: practiceColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: practiceColor, width: 2),
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
                            isCorrect ? 'Perfect! 🎉' : 'Not quite',
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      '/${currentVocab.ipa}/',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
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
                  backgroundColor: practiceColor,
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
                  backgroundColor: practiceColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentQuestionIndex < _exercises.length - 1
                      ? 'Next Question'
                      : 'Finish Practice',
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
