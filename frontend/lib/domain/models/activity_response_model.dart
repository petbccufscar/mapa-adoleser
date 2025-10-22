// lib/models/activity_response_model.dart

class ActivityResponseModel {
  final int id;
  final String locationId;
  final String name;
  final String description;
  final DateTime date;

  ActivityResponseModel({
    required this.id,
    required this.locationId,
    required this.name,
    required this.description,
    required this.date,
  });

  factory ActivityResponseModel.fromJson(Map<String, dynamic> json) {
    return ActivityResponseModel(
      id: json['id'],
      locationId: json['locationId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'locationId': locationId,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ActivityResponseModel{id: $id, locationId: $locationId, name: $name, description: $description, date: ${date.toIso8601String()}}';
  }
}
