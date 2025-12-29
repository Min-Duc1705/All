import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class GrammarCheckDetailScreen extends StatefulWidget {
  final int totalChecks;

  const GrammarCheckDetailScreen({super.key, required this.totalChecks});

  @override
  State<GrammarCheckDetailScreen> createState() => _GrammarCheckDetailScreenState();
}

class _GrammarCheckDetailScreenState extends State<GrammarCheckDetailScreen> {
  List<int> _dailyChecks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        // Sample data for last 7 days
        _dailyChecks = [2, 4, 1, 6, 3, 5, 4];
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final double maxY = _dailyChecks.isEmpty ? 10.0 : (_dailyChecks.reduce((a, b) => a > b ? a : b) + 2).toDouble();
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Grammar Check Stats',
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Total Checks Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade400, Colors.teal.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.psychology, size: 48, color: Colors.white),
                        const SizedBox(height: 12),
                        Text(
                          '${widget.totalChecks}',
                          style: GoogleFonts.lexend(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Total Checks',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // This Week Stats
                  Row(
                    children: [
                      Expanded(
                        child: _statCard(
                          'This Week',
                          '${_dailyChecks.reduce((a, b) => a + b)}',
                          'checks',
                          Colors.green.shade100,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _statCard(
                          'Daily Avg',
                          '${(_dailyChecks.reduce((a, b) => a + b) / 7).toStringAsFixed(1)}',
                          'checks/day',
                          Colors.teal.shade100,
                          Colors.teal,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Text(
                    'Grammar Checks (Last 7 Days)',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Bar Chart
                  Container(
                    height: 220,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: maxY,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                '${rod.toY.toInt()} checks',
                                GoogleFonts.lexend(color: Colors.white, fontSize: 12),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final day = now.subtract(Duration(days: 6 - value.toInt()));
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    DateFormat('E').format(day),
                                    style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                                  ),
                                );
                              },
                              reservedSize: 32,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: GoogleFonts.lexend(fontSize: 11, color: Colors.grey),
                                );
                              },
                            ),
                          ),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: (maxY / 4).toDouble(),
                          getDrawingHorizontalLine: (value) {
                            return FlLine(color: Colors.grey.shade200, strokeWidth: 1);
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: List.generate(7, (index) {
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: _dailyChecks[index].toDouble(),
                                gradient: LinearGradient(
                                  colors: [Colors.green.shade400, Colors.teal.shade400],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                width: 20,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _statCard(String title, String value, String unit, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.lexend(fontSize: 12, color: textColor)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.lexend(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
          Text(unit, style: GoogleFonts.lexend(fontSize: 12, color: textColor.withOpacity(0.7))),
        ],
      ),
    );
  }
}
