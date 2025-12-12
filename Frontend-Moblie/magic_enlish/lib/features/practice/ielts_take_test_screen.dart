import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_enlish/data/models/ielts/ielts_test.dart';
import 'package:magic_enlish/data/services/ielts_service.dart';
import 'package:magic_enlish/features/practice/ielts_result_screen.dart';
import 'package:magic_enlish/core/utils/backend_utils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

class IELTSTakeTestScreen extends StatefulWidget {
  final IELTSTest test;
  final IELTSTestHistory history;

  const IELTSTakeTestScreen({
    super.key,
    required this.test,
    required this.history,
  });

  @override
  State<IELTSTakeTestScreen> createState() => _IELTSTakeTestScreenState();
}

class _IELTSTakeTestScreenState extends State<IELTSTakeTestScreen> {
  final IELTSService _ieltsService = IELTSService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  int _currentQuestionIndex = 0;
  final Map<int, int?> _selectedAnswers = {}; // questionId -> answerId
  bool _isSubmitting = false;
  final int _startTime = DateTime.now().millisecondsSinceEpoch;

  // Audio player state
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.release();
    _audioPlayer.dispose();
    super.dispose();
  }

  /// Reset audio player state when switching questions
  Future<void> _resetAudio() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.release();
    } catch (e) {
      debugPrint('Audio reset error: $e');
    }
    if (mounted) {
      setState(() {
        _isPlaying = false;
        _isLoadingAudio = false;
        _duration = Duration.zero;
        _position = Duration.zero;
      });
    }
  }

  bool _isLoadingAudio = false;

  Future<void> _playAudio(String audioUrl) async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        return;
      }

      // Show loading state
      setState(() {
        _isLoadingAudio = true;
      });

      // Stop any previous audio
      await _audioPlayer.stop();

      // Build full URL and encode properly
      String fullUrl = BackendUtils.getFullUrl(audioUrl);
      String encodedUrl = fullUrl.replaceAll('+', '%20');
      debugPrint('Fetching audio from: $encodedUrl');

      // Fetch audio bytes with http (better timeout control)
      final uri = Uri.parse(encodedUrl);
      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              throw Exception('Audio request timed out. Please try again.');
            },
          );

      if (response.statusCode == 200) {
        final audioBytes = response.bodyBytes;
        debugPrint(
          'Audio fetched successfully, size: ${audioBytes.length} bytes',
        );

        if (audioBytes.length < 100) {
          throw Exception('Invalid audio response');
        }

        // Play from bytes
        await _audioPlayer.play(BytesSource(audioBytes));
      } else {
        throw Exception('Failed to load audio: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Audio Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${e.toString().replaceAll('Exception:', '').trim()}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingAudio = false;
        });
      }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF4A90E2);
    const neutral = Color(0xFFE0E0E0);

    final currentQuestion = widget.test.questions[_currentQuestionIndex];
    final selectedAnswerId = _selectedAnswers[currentQuestion.id];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                border: Border(
                  bottom: BorderSide(color: neutral.withOpacity(0.3), width: 1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _showExitDialog(),
                    child: Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.close,
                        size: 28,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.test.title,
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF333333),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const SizedBox(width: 35),
                ],
              ),
            ),
            const SizedBox(height: 35),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Progress Bar
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Question ${_currentQuestionIndex + 1} of ${widget.test.questions.length}',
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF333333),
                              ),
                            ),
                            Text(
                              '${_selectedAnswers.length}/${widget.test.questions.length} answered',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Stack(
                          children: [
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: neutral.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                            ),
                            FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor:
                                  (_currentQuestionIndex + 1) /
                                  widget.test.questions.length,
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 35),

                    // Audio Player (for Listening skill)
                    if (widget.test.skill == 'Listening') ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              primary.withOpacity(0.1),
                              primary.withOpacity(0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: primary.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.headphones,
                                  color: primary,
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Listening Audio',
                                  style: GoogleFonts.lexend(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Play/Pause Button
                            GestureDetector(
                              onTap: _isLoadingAudio
                                  ? null
                                  : currentQuestion.audioUrl != null &&
                                        currentQuestion.audioUrl!.isNotEmpty
                                  ? () => _playAudio(currentQuestion.audioUrl!)
                                  : () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Audio is being generated...',
                                          ),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: _isLoadingAudio
                                      ? Colors.grey
                                      : primary,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: _isLoadingAudio
                                    ? const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : Icon(
                                        _isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Progress Bar
                            Column(
                              children: [
                                SliderTheme(
                                  data: SliderThemeData(
                                    activeTrackColor: primary,
                                    inactiveTrackColor: Colors.grey[300],
                                    thumbColor: primary,
                                    overlayColor: primary.withOpacity(0.2),
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 6,
                                    ),
                                  ),
                                  child: Slider(
                                    min: 0,
                                    max: _duration.inSeconds.toDouble() > 0
                                        ? _duration.inSeconds.toDouble()
                                        : 1.0,
                                    value: _position.inSeconds.toDouble().clamp(
                                      0.0,
                                      _duration.inSeconds.toDouble() > 0
                                          ? _duration.inSeconds.toDouble()
                                          : 1.0,
                                    ),
                                    onChanged: (value) async {
                                      if (_duration.inSeconds > 0) {
                                        await _audioPlayer.seek(
                                          Duration(seconds: value.toInt()),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatDuration(_position),
                                        style: GoogleFonts.lexend(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        _formatDuration(_duration),
                                        style: GoogleFonts.lexend(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Hint Text
                            if (currentQuestion.audioUrl != null &&
                                currentQuestion.audioUrl!.isNotEmpty)
                              Text(
                                'Listen carefully to answer the question',
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            else
                              Text(
                                'Audio URL: ${currentQuestion.audioUrl ?? "No audio available"}',
                                style: GoogleFonts.lexend(
                                  fontSize: 11,
                                  color: Colors.red[600],
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Passage (for Reading skill)
                    if (widget.test.skill == 'Reading' &&
                        currentQuestion.passage != null &&
                        currentQuestion.passage!.isNotEmpty) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.article, color: primary, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'Reading Passage',
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              currentQuestion.passage!,
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                color: const Color(0xFF333333),
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Question
                    Text(
                      currentQuestion.questionText,
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF333333),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Answer Options
                    ...currentQuestion.answers.map((answer) {
                      final isSelected = selectedAnswerId == answer.id;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedAnswers[currentQuestion.id] = answer.id;
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? primary.withOpacity(0.1)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? primary
                                    : neutral.withOpacity(0.8),
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Radio Button
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? primary : neutral,
                                      width: 2,
                                    ),
                                    color: isSelected
                                        ? primary
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? Center(
                                          child: Container(
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                // Answer Option
                                Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? primary
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    answer.answerOption,
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey[700],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    answer.answerText,
                                    style: GoogleFonts.lexend(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF333333),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Action Bar
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                border: Border(
                  top: BorderSide(color: neutral.withOpacity(0.5), width: 1),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Back Button
                  if (_currentQuestionIndex > 0)
                    TextButton.icon(
                      onPressed: () {
                        _resetAudio();
                        setState(() {
                          _currentQuestionIndex--;
                        });
                      },
                      icon: const Icon(Icons.arrow_back, size: 20),
                      label: Text(
                        'Back',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(
                          0xFF333333,
                        ).withOpacity(0.8),
                      ),
                    ),
                  const SizedBox(width: 8),
                  // Next/Submit Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isSubmitting
                          ? null
                          : () {
                              if (_currentQuestionIndex <
                                  widget.test.questions.length - 1) {
                                // Next question
                                _resetAudio();
                                setState(() {
                                  _currentQuestionIndex++;
                                });
                              } else {
                                // Submit test
                                _submitTest();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        elevation: 0,
                        disabledBackgroundColor: neutral,
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              _currentQuestionIndex <
                                      widget.test.questions.length - 1
                                  ? 'Next'
                                  : 'Submit Test',
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Exit Test?',
          style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Your progress will be lost if you exit now.',
          style: GoogleFonts.lexend(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.lexend()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Exit test
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Exit', style: GoogleFonts.lexend(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _submitTest() async {
    // Check if all questions are answered
    if (_selectedAnswers.length < widget.test.questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please answer all questions before submitting',
            style: GoogleFonts.lexend(),
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Calculate time spent
      int timeSpent =
          ((DateTime.now().millisecondsSinceEpoch - _startTime) / 1000).round();

      // Prepare answers
      List<Map<String, dynamic>> answers = [];
      for (var question in widget.test.questions) {
        answers.add({
          'questionId': question.id,
          'selectedAnswerId': _selectedAnswers[question.id],
        });
      }

      // Submit test
      final result = await _ieltsService.submitTest(
        historyId: widget.history.id,
        answers: answers,
        timeSpentSeconds: timeSpent,
      );

      if (!mounted) return;

      // Navigate to result screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              IELTSResultScreen(result: result, test: widget.test),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to submit test: ${e.toString()}',
            style: GoogleFonts.lexend(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}
