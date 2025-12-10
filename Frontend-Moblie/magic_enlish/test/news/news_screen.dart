import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String selectedCategory = "All";
  final List<String> categories = [
    "All",
    "News",
    "Sports",
    "Business",
    "Tech",
    "Travel",
    "Life",
    "World",
  ];

  final TextEditingController _searchController = TextEditingController();

  // Static news data
  final List<Map<String, dynamic>> _allNews = [
    {
      'title': 'Breaking: New Technology Revolutionizes Education',
      'description':
          'AI-powered learning platforms are transforming how students learn English worldwide.',
      'category': 'Tech',
      'imageUrl': 'https://via.placeholder.com/400x200/4A90E2/FFFFFF?text=Tech+News',
      'author': 'John Smith',
      'publishedAt': '2 hours ago',
    },
    {
      'title': 'World Cup 2024: Teams Prepare for Finals',
      'description':
          'Top football teams from around the globe are gearing up for the championship match.',
      'category': 'Sports',
      'imageUrl': 'https://via.placeholder.com/400x200/10B981/FFFFFF?text=Sports',
      'author': 'Sarah Johnson',
      'publishedAt': '5 hours ago',
    },
    {
      'title': 'Global Markets Show Strong Recovery',
      'description':
          'Stock markets across the world are experiencing unprecedented growth this quarter.',
      'category': 'Business',
      'imageUrl': 'https://via.placeholder.com/400x200/F97316/FFFFFF?text=Business',
      'author': 'Michael Chen',
      'publishedAt': '1 day ago',
    },
    {
      'title': 'Discover Hidden Gems in Southeast Asia',
      'description':
          'Travel experts reveal the most beautiful and affordable destinations for 2024.',
      'category': 'Travel',
      'imageUrl': 'https://via.placeholder.com/400x200/9B59B6/FFFFFF?text=Travel',
      'author': 'Emily Brown',
      'publishedAt': '2 days ago',
    },
    {
      'title': 'Health Benefits of Mediterranean Diet',
      'description':
          'New study reveals how Mediterranean eating habits can improve longevity.',
      'category': 'Life',
      'imageUrl': 'https://via.placeholder.com/400x200/EF4444/FFFFFF?text=Life',
      'author': 'Dr. James Wilson',
      'publishedAt': '3 days ago',
    },
    {
      'title': 'Climate Summit Reaches Historic Agreement',
      'description':
          'World leaders commit to ambitious targets to combat climate change.',
      'category': 'World',
      'imageUrl': 'https://via.placeholder.com/400x200/059669/FFFFFF?text=World',
      'author': 'Maria Garcia',
      'publishedAt': '4 days ago',
    },
    {
      'title': 'Local Community Celebrates Cultural Festival',
      'description':
          'Thousands gather for annual celebration showcasing diverse traditions.',
      'category': 'News',
      'imageUrl': 'https://via.placeholder.com/400x200/3B82F6/FFFFFF?text=News',
      'author': 'David Lee',
      'publishedAt': '1 week ago',
    },
    {
      'title': 'Innovative Startup Secures Major Funding',
      'description': 'Tech startup raises to expand AI-driven education platform.',
      'category': 'Business',
      'imageUrl': 'https://via.placeholder.com/400x200/F59E0B/FFFFFF?text=Business',
      'author': 'Lisa Anderson',
      'publishedAt': '1 week ago',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredNews {
    var filtered = _allNews;

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((news) => news['category'] == selectedCategory).toList();
    }

    // Filter by search
    if (_searchController.text.isNotEmpty) {
      final search = _searchController.text.toLowerCase();
      filtered = filtered.where((news) {
        final title = news['title'].toString().toLowerCase();
        final description = news['description'].toString().toLowerCase();
        return title.contains(search) || description.contains(search);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final displayedNews = _filteredNews;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 28),
                  ),
                  const Spacer(),
                  Text(
                    'News',
                    style: GoogleFonts.lexend(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search news...',
                  prefixIcon: const Icon(Icons.search),
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

            // Category Tabs
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF4A90E2) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF4A90E2).withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: GoogleFonts.lexend(
                              color: isSelected ? Colors.white : Colors.grey[700],
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // News List
            Expanded(
              child: displayedNews.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.article_outlined, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'No news found',
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
                      itemCount: displayedNews.length,
                      itemBuilder: (context, index) {
                        final article = displayedNews[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildNewsCard(article),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4A90E2),
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

  Widget _buildNewsCard(Map<String, dynamic> article) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening: ${article['title']}')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 180,
                width: double.infinity,
                color: Colors.grey[200],
                child: Icon(
                  Icons.image,
                  size: 64,
                  color: Colors.grey[400],
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A90E2).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      article['category'],
                      style: GoogleFonts.lexend(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4A90E2),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Title
                  Text(
                    article['title'],
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    article['description'],
                    style: GoogleFonts.lexend(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  // Author and Time
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: const Color(0xFF4A90E2).withOpacity(0.2),
                        child: Icon(
                          Icons.person,
                          size: 14,
                          color: const Color(0xFF4A90E2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          article['author'],
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Icon(Icons.access_time, size: 14, color: Colors.grey[400]),
                      const SizedBox(width: 4),
                      Text(
                        article['publishedAt'],
                        style: GoogleFonts.lexend(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
