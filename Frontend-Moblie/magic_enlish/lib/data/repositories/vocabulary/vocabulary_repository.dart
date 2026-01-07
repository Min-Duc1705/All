import 'package:magic_enlish/data/models/vocabulary/Vocabulary.dart';
import 'package:magic_enlish/data/services/vocabulary_service.dart';

class VocabularyRepository {
  final VocabularyService _vocabularyService;

  VocabularyRepository({VocabularyService? vocabularyService})
    : _vocabularyService = vocabularyService ?? VocabularyService();

  /// Add new word to vocabulary
  /// Returns Vocabulary object if successful
  /// Throws Exception if adding word fails
  Future<Vocabulary> addNewWord(Vocabulary vocabulary) async {
    try {
      final response = await _vocabularyService.addNewWord(vocabulary);

      if (response.statusCode == 201 && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message ?? 'Failed to add word');
      }
    } catch (e) {
      throw Exception('Add word error: ${e.toString()}');
    }
  }

  /// Get all vocabulary with pagination and search
  /// Returns list of Vocabulary objects
  /// Throws Exception if fetching fails
  Future<List<Vocabulary>> getAllVocabulary({
    String? search,
    int page = 1,
    int size = 10,
  }) async {
    try {
      final response = await _vocabularyService.getAllVocabulary(
        search: search,
        page: page,
        size: size,
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message ?? 'Failed to fetch vocabulary');
      }
    } catch (e) {
      throw Exception('Fetch vocabulary error: ${e.toString()}');
    }
  }

  /// Preview vocabulary without saving
  /// Used for live preview in add word screen
  /// Returns Vocabulary object with AI-generated data
  /// Throws Exception if preview fails
  Future<Vocabulary> previewVocabulary(Vocabulary vocabulary) async {
    try {
      final response = await _vocabularyService.previewVocabulary(vocabulary);

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message ?? 'Failed to preview word');
      }
    } catch (e) {
      // Handle specific timeout errors
      if (e.toString().contains('timeout')) {
        throw Exception(
          'Preview is taking longer than usual. Please try again.',
        );
      }
      throw Exception('Preview error: ${e.toString()}');
    }
  }

  Future<List<Vocabulary>> searchVocabulary(String keyword) async {
    return getAllVocabulary(search: keyword, page: 1, size: 50);
  }

  /// Delete vocabulary by ID
  Future<void> deleteVocabulary(int id) async {
    try {
      final response = await _vocabularyService.deleteVocabulary(id);

      if (response.statusCode != 204) {
        throw Exception(response.message ?? 'Failed to delete word');
      }
    } catch (e) {
      throw Exception('Delete word error: ${e.toString()}');
    }
  }

  /// Update vocabulary
  Future<Vocabulary> updateVocabulary(Vocabulary vocabulary) async {
    try {
      final response = await _vocabularyService.updateVocabulary(vocabulary);

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message ?? 'Failed to update word');
      }
    } catch (e) {
      throw Exception('Update word error: ${e.toString()}');
    }
  }
}
