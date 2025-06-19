/// 리뷰 데이터 모델
class Review {
  final String user;
  final int score;
  final String comment;
  final DateTime date;

  Review({required this.user, required this.score, required this.comment, required this.date});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    user: json['user'],
    score: json['score'],
    comment: json['comment'],
    date: DateTime.parse(json['date']),
  );
} 