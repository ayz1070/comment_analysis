import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entity/review_analysis_entity.dart';
import 'review_analysis_local_datasource.dart';

class ReviewAnalysisLocalDataSourceImpl implements ReviewAnalysisLocalDataSource {
  @override
  Future<ReviewAnalysisEntity> loadAnalysisResult() async {
    final String jsonString = await rootBundle.loadString('lib/assets/analysis_result.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return _fromJson(jsonData);
  }

  ReviewAnalysisEntity _fromJson(Map<String, dynamic> json) {
    final overallCounts = (json['overall_counts'] as Map).map((k, v) => MapEntry(int.parse(k), v as int));
    final analysis = (json['analysis'] as Map).map((k, v) => MapEntry(
      int.parse(k),
      ReviewScoreAnalysis(
        reviewCount: v['review_count'],
        topWords: (v['top_words'] as List)
            .map((w) => WordFrequency(word: w['word'], frequency: w['frequency']))
            .toList(),
      ),
    ));
    return ReviewAnalysisEntity(
      totalReviews: json['total_reviews'],
      overallCounts: overallCounts,
      analysis: analysis,
    );
  }
} 