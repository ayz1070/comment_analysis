import '../entity/review_analysis_entity.dart';

abstract class ReviewAnalysisRepository {
  Future<ReviewAnalysisEntity> getAnalysisResult();
} 