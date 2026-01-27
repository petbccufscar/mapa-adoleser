import 'package:mapa_adoleser/domain/responses/category_response_model.dart';

class CategoryModel {
  final String id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CategoryModel.fromResponse(CategoryResponseModel response) {
    return CategoryModel(
      id: response.id,
      name: response.name,
    );
  }
}
