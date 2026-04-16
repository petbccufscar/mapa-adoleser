// lib/models/forgot_password_email_request_model.dart

class ForgotPasswordEmailRequestModel {
  final String email;

  ForgotPasswordEmailRequestModel({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
