class RelatedActivityResponseModel {
  final String id;
  final String name;
  final String address;
  final double averageRating;
  final int ratingCount;

  RelatedActivityResponseModel({
    required this.id,
    required this.name,
    required this.address,
    required this.averageRating,
    required this.ratingCount,
  });

  factory RelatedActivityResponseModel.fromJson(Map<String, dynamic> json) {
    return RelatedActivityResponseModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      averageRating: (json['averageRating'] as num).toDouble(),
      ratingCount: json['ratingCount'],
    );
  }
}
