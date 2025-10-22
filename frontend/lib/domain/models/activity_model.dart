// lib/models/activity_model.dart

class ActivityModel {
  final int id;
  final String locationId;
  final String name;
  final String description;
  final DateTime date;

  ActivityModel({
    required this.id,
    required this.locationId,
    required this.name,
    required this.description,
    required this.date,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
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
    return 'ActivityModel{id: $id, locationId: $locationId, name: $name, description: $description, date: ${date.toIso8601String()}}';
  }
}
