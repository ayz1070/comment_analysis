import 'package:get/get.dart';
import '../../domain/entity/review_analysis_entity.dart';
import '../../domain/usecase/get_review_analysis_usecase.dart';

class ReviewAnalysisController extends GetxController {
  final GetReviewAnalysisUseCase getReviewAnalysisUseCase;
  ReviewAnalysisController(this.getReviewAnalysisUseCase);

  var isLoading = true.obs;
  var analysisResult = Rxn<ReviewAnalysisEntity>();
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAnalysis();
  }

  Future<void> loadAnalysis() async {
    isLoading.value = true;
    error.value = '';
    try {
      final result = await getReviewAnalysisUseCase();
      analysisResult.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
} 