import 'package:flutter/material.dart';

/// 점수별 리뷰 개수 차트 위젯 (예시)
class ReviewChart extends StatelessWidget {
  final Map<int, int> scoreCount;
  const ReviewChart({super.key, required this.scoreCount});

  @override
  Widget build(BuildContext context) {
    // TODO: fl_chart 등으로 시각화 구현
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: const Center(child: Text('차트 영역')),
    );
  }
} 