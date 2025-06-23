import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entity/review_analysis_entity.dart';
import '../../core/app_colors.dart';

class ReviewPieChart extends StatelessWidget {
  final List<WordFrequency> topWords;
  final double maxWidth;
  const ReviewPieChart({super.key, required this.topWords, this.maxWidth = 420});

  List<Color> getPieColors(int count) {
    return List.generate(count, (i) {
      final double t = i / (count == 1 ? 1 : (count - 1));
      return Color.lerp(AppColors.main, Colors.white, t * 0.7)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (topWords.isEmpty) {
      return const Text('데이터 없음');
    }
    final total = topWords.fold<int>(0, (sum, w) => sum + w.frequency);
    final colors = getPieColors(topWords.length);
    return SizedBox(
      height: 260,
      width: maxWidth,
      child: PieChart(
        PieChartData(
          sections: List.generate(topWords.length, (i) {
            final w = topWords[i];
            return PieChartSectionData(
              value: w.frequency.toDouble(),
              color: colors[i],
              title: '${w.word}(${w.frequency})',
              titleStyle: GoogleFonts.notoSansKr(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black87),
              radius: 90,
              showTitle: true,
            );
          }),
          sectionsSpace: 2,
          centerSpaceRadius: 50,
          pieTouchData: PieTouchData(enabled: true),
        ),
        swapAnimationDuration: const Duration(milliseconds: 900),
        swapAnimationCurve: Curves.easeInOutCubic,
      ),
    );
  }
} 