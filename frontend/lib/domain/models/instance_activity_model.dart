import 'package:mapa_adoleser/domain/responses/instece_activity_response_model.dart';

class InstanceActivityModel {
  final String id;
  final String name;

  InstanceActivityModel({required this.id, required this.name});

  factory InstanceActivityModel.fromJson(Map<String, dynamic> json) {
    return InstanceActivityModel(
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

  factory InstanceActivityModel.fromResponse(
      InstanceActivityResponseModel response) {
    return InstanceActivityModel(
      id: response.id,
      name: response.name,
    );
  }
}
