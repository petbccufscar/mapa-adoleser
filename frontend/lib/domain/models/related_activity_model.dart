import 'package:mapa_adoleser/domain/responses/related_activity_response_model.dart';

class RelatedActivityModel {
  final String id;
  final String name;
  final double averageRating;
  final int ratingCount;

  RelatedActivityModel({
    required this.id,
    required this.name,
    required this.averageRating,
    required this.ratingCount,
  });

  factory RelatedActivityModel.fromJson(Map<String, dynamic> json) {
    return RelatedActivityModel(
      id: json['id'],
      name: json['name'],
      averageRating: (json['averageRating'] as num).toDouble(),
      ratingCount: json['ratingCount'],
    );
  }

  factory RelatedActivityModel.fromResponse(
      RelatedActivityResponseModel response) {
    return RelatedActivityModel(
        id: response.id,
        name: response.name,
        averageRating: response.averageRating,
        ratingCount: response.ratingCount);
  }
}
