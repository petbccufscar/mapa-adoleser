class ForgotPasswordCheckCodeResponseModel {
  final bool success;

  const ForgotPasswordCheckCodeResponseModel({
    required this.success,
  });

  factory ForgotPasswordCheckCodeResponseModel.fromJson(
      Map<String, dynamic> json) {
    return ForgotPasswordCheckCodeResponseModel(
      success: json['success'] ?? false,
    );
  }
}
