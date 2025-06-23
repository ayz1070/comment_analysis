import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entity/review_analysis_entity.dart';
import '../../core/app_colors.dart';

class ReviewWordList extends StatelessWidget {
  final List<WordFrequency> topWords;
  final double maxWidth;
  const ReviewWordList({super.key, required this.topWords, this.maxWidth = 420});

  List<Color> getPieColors(int count) {
    return List.generate(count, (i) {
      final double t = i / (count == 1 ? 1 : (count - 1));
      return Color.lerp(AppColors.main, Colors.white, t * 0.7)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = topWords.fold<int>(0, (sum, w) => sum + w.frequency);
    final colors = getPieColors(topWords.length);
    return Column(
      children: List.generate(topWords.length, (i) {
        final w = topWords[i];
        final percent = (w.frequency / total * 100).toStringAsFixed(1);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: colors[i],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                w.word,
                style: GoogleFonts.notoSansKr(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(width: 8),
              Text('(${w.frequency})', style: GoogleFonts.notoSansKr(color: Colors.grey, fontSize: 14)),
              const Spacer(),
              Text('$percent%', style: GoogleFonts.notoSansKr(fontWeight: FontWeight.w500, fontSize: 14)),
            ],
          ),
        );
      }),
    );
  }
} 