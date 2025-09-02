// lib/models/login_request_model.dart

class LoginRequestModel {
  final String username;
  final String password;

  LoginRequestModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
