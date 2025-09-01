// lib/models/forgot_password_email_request_model.dart

class ForgotPasswordCodeRequestModel {
  final String code;

  ForgotPasswordCodeRequestModel({
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}
