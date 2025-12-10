import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_enlish/core/widgets/vocabulary/cefr_level_badge.dart';
import 'package:magic_enlish/core/widgets/vocabulary/example_item_widget.dart';
import 'package:magic_enlish/data/models/vocabulary/Vocabulary.dart';

class VocabularyPreviewCard extends StatelessWidget {
  final Vocabulary? vocabulary;
  final bool isLoading;
  final Color primaryColor;

  const VocabularyPreviewCard({
    super.key,
    this.vocabulary,
    this.isLoading = false,
    this.primaryColor = const Color(0xFF3A57E8),
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (vocabulary == null) {
      return _buildEmptyState();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Word and IPA
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vocabulary!.word,
                      style: GoogleFonts.lexend(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (vocabulary!.ipa.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        vocabulary!.ipa,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontFamily: 'serif',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.volume_up, color: primaryColor, size: 26),
            ],
          ),

          const SizedBox(height: 16),
          Container(height: 1.2, color: Colors.grey.shade300),
          const SizedBox(height: 16),

          // Meaning
          if (vocabulary!.meaning.isNotEmpty) ...[
            Text(
              "Meaning",
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              vocabulary!.meaning,
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Word Type and CEFR Level
          Row(
            children: [
              if (vocabulary!.wordType.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Type",
                        style: GoogleFonts.lexend(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        vocabulary!.wordType,
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              if (vocabulary!.cefrLevel.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Level",
                        style: GoogleFonts.lexend(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      CefrLevelBadge(
                        level: vocabulary!.cefrLevel,
                        animated: false,
                        fontSize: 12,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // Examples
          if (vocabulary!.example.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              "Example",
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 6),
            ...vocabulary!.example
                .split('\n')
                .where((e) => e.trim().isNotEmpty)
                .take(2)
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: ExampleItem(text: e, iconColor: primaryColor),
                  ),
                ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          CircularProgressIndicator(color: primaryColor),
          const SizedBox(height: 16),
          Text(
            'Looking up word...',
            style: GoogleFonts.lexend(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(Icons.search, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            'Preview will appear here',
            style: GoogleFonts.lexend(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
