import 'package:get/get.dart';

import '../../data/datasource/review_analysis_local_datasource.dart';
import '../../data/datasource/review_analysis_local_datasource_impl.dart';
import '../../data/repository/review_analysis_repository_impl.dart';
import '../../domain/repository/review_analysis_repository.dart';
import '../../domain/usecase/get_review_analysis_usecase.dart';
import '../../presentation/controller/review_analysis_controller.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewAnalysisLocalDataSource>(() => ReviewAnalysisLocalDataSourceImpl());
    Get.lazyPut<ReviewAnalysisRepository>(() => ReviewAnalysisRepositoryImpl(Get.find()));
    Get.lazyPut<GetReviewAnalysisUseCase>(() => GetReviewAnalysisUseCase(Get.find()));
    Get.lazyPut<ReviewAnalysisController>(() => ReviewAnalysisController(Get.find()));
  }
} 