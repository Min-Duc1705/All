import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Color get primary => const Color(0xFF4A90E2);
  Color get background => const Color(0xFFF4F6F9);
  Color get cardColor => Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Help & Support',
          style: GoogleFonts.lexend(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF333333),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary, primary.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.support_agent,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'How can we help you?',
                    style: GoogleFonts.lexend(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We\'re here to assist you 24/7',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // FAQ Section
            Text(
              'Frequently Asked Questions',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            _buildFaqItem(
              'How do I reset my password?',
              'Go to Settings > Account > Change Password. Enter your current password and set a new one.',
            ),
            _buildFaqItem(
              'How can I track my learning progress?',
              'Visit the Dashboard to see your learning statistics, completed lessons, and achievements.',
            ),
            _buildFaqItem(
              'How do I enable push notifications?',
              'Go to Profile > General > Push Notifications and toggle it on.',
            ),
            _buildFaqItem(
              'Can I learn offline?',
              'Yes! Download lessons when connected to the internet and access them anytime offline.',
            ),
            const SizedBox(height: 24),

            // Contact Section
            Text(
              'Contact Us',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            _buildContactItem(
              Icons.email_outlined,
              'Email Support',
              'support@magicenglish.com',
              () {},
            ),
            _buildContactItem(
              Icons.chat_bubble_outline,
              'Live Chat',
              'Available 24/7',
              () {},
            ),
            _buildContactItem(
              Icons.phone_outlined,
              'Phone Support',
              '+84 123 456 789',
              () {},
            ),
            const SizedBox(height: 24),

            // Quick Links
            Text(
              'Quick Links',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildQuickLink(
                    Icons.video_library_outlined,
                    'Video Tutorials',
                    () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickLink(
                    Icons.article_outlined,
                    'User Guide',
                    () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildQuickLink(
                    Icons.forum_outlined,
                    'Community Forum',
                    () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickLink(
                    Icons.feedback_outlined,
                    'Send Feedback',
                    () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Text(
          question,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        children: [
          Text(
            answer,
            style: GoogleFonts.lexend(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: primary, size: 24),
        ),
        title: Text(
          title,
          style: GoogleFonts.lexend(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.lexend(fontSize: 13, color: Colors.grey[600]),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }

  Widget _buildQuickLink(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: primary, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
