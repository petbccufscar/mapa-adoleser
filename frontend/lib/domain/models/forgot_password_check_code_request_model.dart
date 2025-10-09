// lib/models/forgot_password_email_request_model.dart

class ForgotPasswordCheckCodeRequestModel {
  final String code;

  ForgotPasswordCheckCodeRequestModel({
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}
