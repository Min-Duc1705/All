import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_enlish/core/widgets/common/app_bottom_nav.dart';
import 'package:magic_enlish/core/widgets/progress/donut_chart_card.dart';
import 'package:magic_enlish/core/widgets/progress/bar_chart_card.dart';
import 'package:magic_enlish/core/widgets/profile/stats_grid.dart';
import 'package:magic_enlish/providers/progress/progress_provider.dart';
import 'package:provider/provider.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProgressProvider>().loadProgressData();
    });
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF4A90E2);
    const accent = Color(0xFFF8D648);
    const background = Color(0xFFF9F9F9);
    const textColor = Color(0xFF100d1b);

    return Consumer<ProgressProvider>(
      builder: (context, progressProvider, child) {
        return Scaffold(
          backgroundColor: background,
          body: SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: const Icon(Icons.person, size: 24),
                      ),
                      Expanded(
                        child: Text(
                          'My Progress',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 48,
                        child: IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          color: textColor,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: progressProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : progressProvider.errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 48,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Failed to load progress data',
                                style: GoogleFonts.lexend(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () =>
                                    progressProvider.refreshProgressData(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () =>
                              progressProvider.refreshProgressData(),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Stats Grid (reusing StatsGrid component)
                                _buildStatsGrid(
                                  progressProvider,
                                  accent,
                                  primary,
                                ),

                                const SizedBox(height: 24),

                                // Achievements Section (hardcoded for now)
                                _buildAchievementsSection(textColor),

                                const SizedBox(height: 24),

                                // Vocabulary Breakdown
                                if (progressProvider.vocabularyBreakdown !=
                                    null)
                                  DonutChartCard(
                                    breakdown:
                                        progressProvider.vocabularyBreakdown!,
                                  ),

                                const SizedBox(height: 16),

                                // CEFR Level Distribution
                                if (progressProvider.cefrDistribution != null)
                                  BarChartCard(
                                    distribution:
                                        progressProvider.cefrDistribution!,
                                  ),

                                const SizedBox(height: 80),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const AppBottomNav(currentIndex: 3),
        );
      },
    );
  }

  Widget _buildAchievementsSection(Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Achievements',
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 4),
            children: [
              _achievementBadge(
                title: 'Word Wizard',
                subtitle: '100 words',
                isLocked: false,
              ),
              _achievementBadge(
                title: 'Grammar Guru',
                subtitle: '50 tasks',
                isLocked: false,
              ),
              _achievementBadge(
                title: 'Streak Champ',
                subtitle: '7-day streak',
                isLocked: false,
              ),
              _achievementBadge(
                title: 'Locked',
                subtitle: 'Keep going!',
                isLocked: true,
              ),
              _achievementBadge(
                title: 'Locked',
                subtitle: 'Keep going!',
                isLocked: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(
    ProgressProvider progressProvider,
    Color accent,
    Color primary,
  ) {
    return StatsGrid(
      streakDays: progressProvider.longestStreak,
      wordsToday: progressProvider.totalVocabularyCount,
      masteredWords: progressProvider.totalGrammarChecks,
      quizScore: progressProvider.avgGrammarScoreTotal,
      quizTotal: 100,
      cardTitles: const [
        'Longest',
        'Vocabulary',
        'Grammar Check',
        'Grammar Score',
      ],
      cardSubtitles: const ['Streak', 'Total', 'Total', 'Avg Total'],
    );
  }

  Widget _achievementBadge({
    required String title,
    required String subtitle,
    required bool isLocked,
  }) {
    const textColor = Color(0xFF100d1b);
    const textMuted = Color(0xFF888888);

    return Container(
      width: 96,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: Icon(
              Icons.emoji_events,
              size: 40,
              color: isLocked ? Colors.grey : Colors.amber,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isLocked ? textMuted : textColor,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(fontSize: 12, color: textMuted),
          ),
        ],
      ),
    );
  }
}
