import 'package:flutter/foundation.dart';
import 'package:magic_enlish/data/models/progress/progress_data.dart';
import 'package:magic_enlish/data/repositories/progress/progress_repository.dart';
import 'package:magic_enlish/data/repositories/home/home_repository.dart';

class ProgressProvider with ChangeNotifier {
  final ProgressRepository _progressRepository = ProgressRepository();
  final HomeRepository _homeRepository = HomeRepository();

  VocabularyBreakdown? _vocabularyBreakdown;
  CefrDistribution? _cefrDistribution;
  int _totalVocabularyCount = 0;
  int _longestStreak = 0;
  int _totalGrammarChecks = 0;
  int _avgGrammarScoreTotal = 0;
  bool _isLoading = false;
  String? _errorMessage;

  VocabularyBreakdown? get vocabularyBreakdown => _vocabularyBreakdown;
  CefrDistribution? get cefrDistribution => _cefrDistribution;
  int get totalVocabularyCount => _totalVocabularyCount;
  int get longestStreak => _longestStreak;
  int get totalGrammarChecks => _totalGrammarChecks;
  int get avgGrammarScoreTotal => _avgGrammarScoreTotal;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load all progress data
  Future<void> loadProgressData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Load home stats to get longestStreak, totalChecks, avgGrammarScoreTotal
      final homeStats = await _homeRepository.getHomeStats();

      _longestStreak = homeStats['longestStreak'] ?? 0;
      _totalGrammarChecks = homeStats['totalChecks'] ?? 0;
      _avgGrammarScoreTotal = homeStats['avgGrammarScoreTotal'] ?? 0;

      final results = await Future.wait([
        _progressRepository.getVocabularyBreakdown(),
        _progressRepository.getCefrLevelDistribution(),
        _progressRepository.getTotalVocabularyCount(),
      ]);

      _vocabularyBreakdown = VocabularyBreakdown.fromJson(
        results[0] as Map<String, int>,
      );
      _cefrDistribution = CefrDistribution.fromJson(
        results[1] as Map<String, int>,
      );
      _totalVocabularyCount = results[2] as int;

      _isLoading = false;
      _errorMessage = null; // Clear error on success
      notifyListeners();
    } catch (e) {
      print('❌ Progress data error: $e');
      // Don't show error, just show empty data
      _vocabularyBreakdown = VocabularyBreakdown.fromJson({
        'verb': 0,
        'noun': 0,
        'adjective': 0,
        'adverb': 0,
        'other': 0,
      });
      _cefrDistribution = CefrDistribution.fromJson({
        'A1': 0,
        'A2': 0,
        'B1': 0,
        'B2': 0,
        'C1': 0,
        'C2': 0,
      });
      _totalVocabularyCount = 0;
      _longestStreak = 0;
      _totalGrammarChecks = 0;
      _avgGrammarScoreTotal = 0;
      _errorMessage = null; // Don't show error UI
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh progress data
  Future<void> refreshProgressData() async {
    await loadProgressData();
  }
}
