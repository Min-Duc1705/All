import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_enlish/data/models/vocabulary/Vocabulary.dart';

class RecentWordsSection extends StatelessWidget {
  final List<Vocabulary> recentWords;
  final bool isLoading;
  final String? error;

  const RecentWordsSection({
    super.key,
    required this.recentWords,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recently Added Words",
          style: GoogleFonts.lexend(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        if (isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        else if (error != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                error!,
                style: GoogleFonts.lexend(color: Colors.red, fontSize: 14),
              ),
            ),
          )
        else if (recentWords.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "No words added yet",
                style: GoogleFonts.lexend(color: Colors.grey, fontSize: 14),
              ),
            ),
          )
        else
          ...recentWords.map(
            (vocab) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vocab.word,
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            vocab.meaning,
                            style: GoogleFonts.lexend(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up, size: 20),
                      onPressed: () {
                        // TODO: Implement text-to-speech
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
