import '../../domain/entity/review_analysis_entity.dart';
import '../../domain/repository/review_analysis_repository.dart';
import '../datasource/review_analysis_local_datasource.dart';

class ReviewAnalysisRepositoryImpl implements ReviewAnalysisRepository {
  final ReviewAnalysisLocalDataSource localDataSource;
  ReviewAnalysisRepositoryImpl(this.localDataSource);

  @override
  Future<ReviewAnalysisEntity> getAnalysisResult() {
    return localDataSource.loadAnalysisResult();
  }
} 