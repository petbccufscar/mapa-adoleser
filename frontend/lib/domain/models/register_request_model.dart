// lib/models/register_request_model.dart

class RegisterRequestModel {
  final String email;
  final String name;
  final String username;
  final DateTime birthDate;
  final String password;

  RegisterRequestModel({
    required this.email,
    required this.username,
    required this.name,
    required this.birthDate,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'username': username,
      'birthDate': birthDate.toIso8601String(),
      'password': password,
    };
  }
}
