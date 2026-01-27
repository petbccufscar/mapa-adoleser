import 'package:mapa_adoleser/domain/responses/review_response_model.dart';

class ReviewModel {
  final String id;
  final String name;
  final String comment;
  final double rating;
  final DateTime date;

  ReviewModel({
    required this.id,
    required this.name,
    required this.comment,
    required this.rating,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      name: json['name'],
      comment: json['comment'],
      rating: (json['rating'] as num).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  factory ReviewModel.fromResponse(ReviewResponseModel response) {
    return ReviewModel(
        id: response.id,
        name: response.name,
        comment: response.comment,
        rating: response.rating,
        date: response.date);
  }
}
