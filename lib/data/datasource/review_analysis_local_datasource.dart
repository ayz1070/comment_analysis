import '../../domain/entity/review_analysis_entity.dart';

abstract class ReviewAnalysisLocalDataSource {
  Future<ReviewAnalysisEntity> loadAnalysisResult();
} 