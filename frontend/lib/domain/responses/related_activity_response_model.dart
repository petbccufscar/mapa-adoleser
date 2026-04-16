class RelatedActivityResponseModel {
  final String id;
  final String name;
  final double averageRating;
  final int ratingCount;

  RelatedActivityResponseModel({
    required this.id,
    required this.name,
    required this.averageRating,
    required this.ratingCount,
  });

  factory RelatedActivityResponseModel.fromJson(Map<String, dynamic> json) {
    return RelatedActivityResponseModel(
      id: json['id']?.toString() ?? "",
      name: json['name'] ?? "",
      averageRating: (json['nota'] as num?)?.toDouble() ?? 0.0,
      ratingCount: json['ratingCount'] ?? 0,
    );
  }
}
