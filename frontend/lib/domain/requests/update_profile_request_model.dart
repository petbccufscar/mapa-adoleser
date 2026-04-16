// lib/models/register_request_model.dart

class UpdateProfileRequestModel {
  final String username;
  final String name;
  final DateTime birthDate;

  UpdateProfileRequestModel({
    required this.username,
    required this.name,
    required this.birthDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'birthDate': birthDate.toIso8601String(),
    };
  }
}
