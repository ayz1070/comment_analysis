import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entity/review_analysis_entity.dart';
import '../../core/app_colors.dart';
import 'review_pie_chart.dart';
import 'review_word_list.dart';

class ReviewAnalysisCard extends StatelessWidget {
  final int score;
  final ReviewScoreAnalysis analysis;

  const ReviewAnalysisCard({super.key, required this.score, required this.analysis});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '⭐ $score점 (${analysis.reviewCount}개 리뷰)',
              style: GoogleFonts.notoSansKr(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.main),
            ),
            const SizedBox(height: 12),
            ReviewPieChart(topWords: analysis.topWords),
            const SizedBox(height: 12),
            ReviewWordList(topWords: analysis.topWords),
          ],
        ),
      ),
    );
  }
} 