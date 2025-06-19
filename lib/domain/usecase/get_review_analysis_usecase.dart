import '../entity/review_analysis_entity.dart';
import '../repository/review_analysis_repository.dart';

class GetReviewAnalysisUseCase {
  final ReviewAnalysisRepository repository;
  GetReviewAnalysisUseCase(this.repository);

  Future<ReviewAnalysisEntity> call() {
    return repository.getAnalysisResult();
  }
} 