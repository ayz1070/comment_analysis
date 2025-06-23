import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entity/review_analysis_entity.dart';
import '../../core/app_colors.dart';
import 'review_analysis_card.dart';

class ReviewListView extends StatelessWidget {
  final ReviewAnalysisEntity result;
  const ReviewListView({super.key, required this.result});

  List<MapEntry<int, ReviewScoreAnalysis>> getSortedScoreEntries(Map<int, ReviewScoreAnalysis> analysis) {
    final entries = analysis.entries.toList();
    entries.sort((a, b) => b.key.compareTo(a.key));
    return entries;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('총 리뷰 수', style: GoogleFonts.notoSansKr(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.main)),
                const SizedBox(height: 6),
                Text('${result.totalReviews}',
                    style: GoogleFonts.notoSansKr(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.main)),
                const SizedBox(height: 16),
                Text('점수별 리뷰 개수', style: GoogleFonts.notoSansKr(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.main)),
                const SizedBox(height: 8),
                ...((result.overallCounts.entries.toList()
                  ..sort((a, b) => b.key.compareTo(a.key)))
                .map((e) =>
                    Text('${e.key}점: ${e.value}개', style: GoogleFonts.notoSansKr(fontSize: 15)))),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text('점수별 주요 단어', style: GoogleFonts.notoSansKr(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.main)),
        ...getSortedScoreEntries(result.analysis).map((entry) {
          return ReviewAnalysisCard(score: entry.key, analysis: entry.value);
        }),
      ],
    );
  }
} 