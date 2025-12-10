import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({super.key});

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = "My Vocabulary";
  String _selectedFilter = "All";

  Color get primary => const Color(0xFF4A90E2);
  Color get background => const Color(0xfff6f6f8);

  // Static data
  final List<Map<String, dynamic>> _vocabularyList = [
    {
      'word': 'Ephemeral',
      'meaning': 'Lasting for a very short time',
      'example': 'The beauty of the sunset was ephemeral.',
      'isFavorite': true,
      'mastered': false,
    },
    {
      'word': 'Serendipity',
      'meaning': 'The occurrence of events by chance in a happy way',
      'example': 'Finding that book was pure serendipity.',
      'isFavorite': false,
      'mastered': true,
    },
    {
      'word': 'Ubiquitous',
      'meaning': 'Present, appearing, or found everywhere',
      'example': 'Smartphones are ubiquitous in modern life.',
      'isFavorite': true,
      'mastered': false,
    },
    {
      'word': 'Eloquent',
      'meaning': 'Fluent or persuasive in speaking or writing',
      'example': 'She gave an eloquent speech at the conference.',
      'isFavorite': false,
      'mastered': true,
    },
    {
      'word': 'Resilient',
      'meaning': 'Able to withstand or recover quickly from difficulties',
      'example': 'The community proved to be resilient after the disaster.',
      'isFavorite': true,
      'mastered': false,
    },
    {
      'word': 'Paradigm',
      'meaning': 'A typical example or pattern of something',
      'example': 'The company set a new paradigm in customer service.',
      'isFavorite': false,
      'mastered': false,
    },
    {
      'word': 'Meticulous',
      'meaning': 'Showing great attention to detail; very careful',
      'example': 'She was meticulous in her research work.',
      'isFavorite': true,
      'mastered': true,
    },
    {
      'word': 'Unprecedented',
      'meaning': 'Never done or known before',
      'example': 'The pandemic brought unprecedented challenges.',
      'isFavorite': false,
      'mastered': false,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredVocabulary {
    var filtered = _vocabularyList;

    // Filter by search
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((vocab) {
        final word = vocab['word'].toString().toLowerCase();
        final meaning = vocab['meaning'].toString().toLowerCase();
        final search = _searchController.text.toLowerCase();
        return word.contains(search) || meaning.contains(search);
      }).toList();
    }

    // Filter by category
    if (_selectedFilter == "Favorites") {
      filtered = filtered.where((vocab) => vocab['isFavorite'] == true).toList();
    } else if (_selectedFilter == "Mastered") {
      filtered = filtered.where((vocab) => vocab['mastered'] == true).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final displayedVocabs = _filteredVocabulary;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            // -------------------- TOP BAR --------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 28),
                  ),
                  const Spacer(),
                  Text(
                    "My Vocabulary",
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Add new word feature')),
                      );
                    },
                    child: const Icon(Icons.add, size: 28),
                  ),
                ],
              ),
            ),

            // -------------------- SEGMENTED BUTTONS --------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSegmentButton(
                      "My Vocabulary",
                      _selectedTab == "My Vocabulary",
                      () => setState(() => _selectedTab = "My Vocabulary"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSegmentButton(
                      "Explore Decks",
                      _selectedTab == "Explore Decks",
                      () => setState(() => _selectedTab = "Explore Decks"),
                    ),
                  ),
                ],
              ),
            ),

            // -------------------- SEARCH BAR --------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search words...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // -------------------- FILTER CHIPS --------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip("All"),
                    const SizedBox(width: 8),
                    _buildFilterChip("Favorites"),
                    const SizedBox(width: 8),
                    _buildFilterChip("Mastered"),
                  ],
                ),
              ),
            ),

            // -------------------- VOCABULARY LIST --------------------
            Expanded(
              child: displayedVocabs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'No words found',
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: displayedVocabs.length,
                      itemBuilder: (context, index) {
                        final vocab = displayedVocabs[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildVocabularyCard(vocab),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Vocabulary'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: 'Practice'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primary : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primary : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.lexend(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildVocabularyCard(Map<String, dynamic> vocab) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  vocab['word'],
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ),
              Row(
                children: [
                  if (vocab['mastered'] == true)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, size: 14, color: Colors.green[700]),
                          const SizedBox(width: 4),
                          Text(
                            'Mastered',
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      vocab['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                      color: vocab['isFavorite'] ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            vocab['meaning'],
            style: GoogleFonts.lexend(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.format_quote, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    vocab['example'],
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primary,
                    side: BorderSide(color: primary),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Delete'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
