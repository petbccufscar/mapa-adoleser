class ForgotPasswordEmailResponseModel {
  final bool success;

  const ForgotPasswordEmailResponseModel({
    required this.success,
  });

  factory ForgotPasswordEmailResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordEmailResponseModel(
      success: json['success'] ?? false,
    );
  }
}
