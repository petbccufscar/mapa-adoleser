class ForgotPasswordCodeResponseModel {
  final bool success;

  const ForgotPasswordCodeResponseModel({
    required this.success,
  });

  factory ForgotPasswordCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordCodeResponseModel(
      success: json['success'] ?? false,
    );
  }
}
