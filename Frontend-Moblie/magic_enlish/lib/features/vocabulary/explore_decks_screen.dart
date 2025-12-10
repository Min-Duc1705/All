import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreDecksScreen extends StatefulWidget {
  const ExploreDecksScreen({super.key});

  @override
  State<ExploreDecksScreen> createState() => _ExploreDecksScreenState();
}

class _ExploreDecksScreenState extends State<ExploreDecksScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedChip = "Popular";

  final List<Map<String, dynamic>> _decks = [
    {
      'title': 'Advanced Business Idioms',
      'wordCount': 150,
      'category': 'Business',
      'rating': 4.8,
      'downloads': '1.2k',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCNAfEUTM-zlHHrDp1raGaWkSt-t2kz_ygN9TF8cfxPsKh9-GKsaEiF9rftMDnRxvPQxeabxDAoxSbnFS_z8xKyR3p9pzOjaGLZG8TFbC9hwQMIlJxmKE9MVOKB3JjJFKf31a2uFJ2uaZ3_k416agDFtj1RD9-7FkXFcsIZ5KBBDUpn9Z77QNOS6UeT75D-DakutuJHUC3uasgla36q_i78iZyx25lPY9wv6hsHM_orX2S2OK6U66m08rEdzDlA62z6duX6FjaqzHc',
    },
    {
      'title': 'Everyday Travel Phrases',
      'wordCount': 80,
      'category': 'Travel',
      'rating': 4.9,
      'downloads': '3.4k',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuC7bPryGgVWkychEyk1CrEp0MfNRbJhSfx2dxUuEiCqHEXohczOy0_t-GkMgKD6By5Xr-U7nLTmEM3iZiNQGR870AARdubFL8GBQjwGoy1tHQvuhLPfraWiGRCX4xkcmeqUmFFb14f8swxgRcaHRRlKN5ZTb3vO0N17-9uHw8KPoycnWqBN58QDXSBA_8SxHBCjuhLWgrqap_tKqRXGIkknIgK75X16xe3jpcinTCo69zflD2v-gkPzDrXApIlqdpmISaNM8La2K1U',
    },
    {
      'title': 'Academic Vocabulary for IELTS',
      'wordCount': 250,
      'category': 'Academic',
      'rating': 4.7,
      'downloads': '980',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAJLg5hVRgN8EYfXOnf1utyO-wKxa2X1TTXSHmkqikhN4_OFtUPeMuKxnnXAEvsMyzfytBlj32UiVxoZW_sxMAgg-csS3BM7p3e0hbObfWSQtGVgmVPtyzi8vId2Z_O_AguZOG31GNxmTDAh7m1ueqZ_vQpUaWZgmb7Cqzmk5wmUL0d5fXnk3iRkbOZ3TFBiiLIULBnOOKdVcxQAuLKvkcTIMIlJ0GnCygeg3VwNSrB7jNVI6sOczb-YImgGqmgfDU3JGFIBJtJUo4',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF1745cf);
    const background = Color(0xFFF6F6F8);

    return Scaffold(
      backgroundColor: background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Create your own deck',
                style: GoogleFonts.plusJakartaSans(),
              ),
            ),
          );
        },
        backgroundColor: primary,
        elevation: 6,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search decks by name or theme',
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: Color(0xFF999999),
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF999999)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: primary, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),

          // Filter Chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              children: [
                _buildChip('Popular', primary),
                const SizedBox(width: 12),
                _buildChip('Newest', primary),
                const SizedBox(width: 12),
                _buildChip('Top Rated', primary),
                const SizedBox(width: 12),
                _buildChip('Travel', primary),
                const SizedBox(width: 12),
                _buildChip('Business', primary),
                const SizedBox(width: 12),
                _buildChip('IELTS', primary),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Deck Cards List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
              itemCount: _decks.length,
              itemBuilder: (context, index) {
                final deck = _decks[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Content
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              deck['title'],
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${deck['wordCount']} words • ${deck['category']}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                color: const Color(0xFF666666),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color(0xFFFFA726),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  deck['rating'].toString(),
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF666666),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.download,
                                  size: 16,
                                  color: Color(0xFF666666),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  deck['downloads'],
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF666666),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Adding ${deck['title']}...',
                                      style: GoogleFonts.plusJakartaSans(),
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary.withOpacity(0.2),
                                foregroundColor: primary,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Add',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Right Image
                      Expanded(
                        flex: 1,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(deck['imageUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color primary) {
    final isSelected = _selectedChip == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedChip = label;
        });
      },
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? primary : const Color(0xFFE5E5E5),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF333333),
            ),
          ),
        ),
      ),
    );
  }
}
