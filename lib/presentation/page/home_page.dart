import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entity/review_analysis_entity.dart';
import '../controller/review_analysis_controller.dart';

const Color mainColor = Color(0xFF59D9C1);

/// 홈 화면: 리뷰 분석 결과 및 차트 페이지로 이동할 수 있는 기본 화면
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Color> getPieColors(int count) {
    return List.generate(count, (i) {
      final double t = i / (count == 1 ? 1 : (count - 1));
      return Color.lerp(mainColor, Colors.white, t * 0.7)!;
    });
  }

  Widget buildPieChart(List<WordFrequency> topWords) {
    if (topWords.isEmpty) {
      return const Text('데이터 없음');
    }
    final total = topWords.fold<int>(0, (sum, w) => sum + w.frequency);
    final colors = getPieColors(topWords.length);
    return SizedBox(
      height: 260,
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

  Widget buildWordList(List<WordFrequency> topWords) {
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

  List<MapEntry<int, ReviewScoreAnalysis>> getSortedScoreEntries(Map<int, ReviewScoreAnalysis> analysis) {
    final entries = analysis.entries.toList();
    entries.sort((a, b) => b.key.compareTo(a.key));
    return entries;
  }

  @override
  Widget build(BuildContext context) {
    // GetX 컨트롤러 DI (최초 1회만)
    Get.lazyPut<ReviewAnalysisController>(() => ReviewAnalysisController(Get.find()));
    return Scaffold(
      appBar: AppBar(
        title: Text('Mofix 리뷰 분석', style: GoogleFonts.notoSansKr(fontWeight: FontWeight.bold)),
        backgroundColor: mainColor,
      ),
      body: GetX<ReviewAnalysisController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.error.isNotEmpty) {
            return Center(child: Text('에러: ${controller.error}', style: GoogleFonts.notoSansKr()));
          }
          final result = controller.analysisResult.value;
          if (result == null) {
            return const Center(child: Text('분석 결과가 없습니다.'));
          }
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
                      Text('총 리뷰 수', style: GoogleFonts.notoSansKr(fontSize: 18, fontWeight: FontWeight.w700, color: mainColor)),
                      const SizedBox(height: 6),
                      Text('${result.totalReviews}',
                          style: GoogleFonts.notoSansKr(fontSize: 32, fontWeight: FontWeight.bold, color: mainColor)),
                      const SizedBox(height: 16),
                      Text('점수별 리뷰 개수', style: GoogleFonts.notoSansKr(fontSize: 17, fontWeight: FontWeight.w600, color: mainColor)),
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
              Text('점수별 주요 단어', style: GoogleFonts.notoSansKr(fontSize: 22, fontWeight: FontWeight.bold, color: mainColor)),
              ...getSortedScoreEntries(result.analysis).map((entry) {
                final score = entry.key;
                final reviewCount = entry.value.reviewCount;
                final topWords = entry.value.topWords;
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
                          '⭐ $score점 (${reviewCount}개 리뷰)',
                          style: GoogleFonts.notoSansKr(fontSize: 18, fontWeight: FontWeight.bold, color: mainColor),
                        ),
                        const SizedBox(height: 12),
                        buildPieChart(topWords),
                        const SizedBox(height: 12),
                        buildWordList(topWords),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
} 