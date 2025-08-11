// lib/models/register_request_model.dart

class RegisterRequestModel {
  final String email;
  final String name;
  final DateTime dateOfBirth;
  final String password;

  RegisterRequestModel({
    required this.email,
    required this.name,
    required this.dateOfBirth,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'password': password,
    };
  }
}
