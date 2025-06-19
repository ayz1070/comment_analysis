class ReviewAnalysisEntity {
  final int totalReviews;
  final Map<int, int> overallCounts;
  final Map<int, ReviewScoreAnalysis> analysis;

  ReviewAnalysisEntity({
    required this.totalReviews,
    required this.overallCounts,
    required this.analysis,
  });
}

class ReviewScoreAnalysis {
  final int reviewCount;
  final List<WordFrequency> topWords;

  ReviewScoreAnalysis({
    required this.reviewCount,
    required this.topWords,
  });
}

class WordFrequency {
  final String word;
  final int frequency;

  WordFrequency({required this.word, required this.frequency});
} 