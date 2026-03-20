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
      id: json['id']?.toString() ?? "",
      name: json['name'] ?? "",
      comment: json['description'] ?? "",
      rating: (json['nota'] as num?)?.toDouble() ?? 0.0,
      date: json['created_at'] != null ? DateTime.tryParse(json['created_at']) ?? DateTime.now() : DateTime.now(),
    );
  }
}
