class ReviewResponseModel {
  final String id;
  final String name;
  final String comment;
  final double rating;
  final DateTime date;

  ReviewResponseModel({
    required this.id,
    required this.name,
    required this.comment,
    required this.rating,
    required this.date,
  });

  factory ReviewResponseModel.fromJson(Map<String, dynamic> json) {
    return ReviewResponseModel(
      id: json['id'],
      name: json['name'],
      comment: json['comment'],
      rating: (json['rating'] as num).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }
}
