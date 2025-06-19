import 'package:flutter/material.dart';

/// 점수별 단어 빈도 워드클라우드 위젯 (예시)
class WordCloud extends StatelessWidget {
  final Map<String, int> wordFrequency;
  const WordCloud({super.key, required this.wordFrequency});

  @override
  Widget build(BuildContext context) {
    // TODO: 워드클라우드 시각화 구현
    return Container(
      height: 200,
      color: Colors.grey[100],
      child: const Center(child: Text('워드클라우드 영역')),
    );
  }
} 