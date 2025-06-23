import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/review_analysis_controller.dart';
import '../widget/primary_app_bar.dart';
import '../widget/review_list_view.dart';

/// 홈 화면: 리뷰 분석 결과 및 차트 페이지로 이동할 수 있는 기본 화면
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const double maxWidth = 420;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ReviewAnalysisController>(() => ReviewAnalysisController(Get.find()));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxWidth),
            child: const PrimaryAppBar(title: 'Mofic'),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxWidth),
          child: GetX<ReviewAnalysisController>(
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
              return ReviewListView(result: result);
            },
          ),
        ),
      ),
    );
  }
} 