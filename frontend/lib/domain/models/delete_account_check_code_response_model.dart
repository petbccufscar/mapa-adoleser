class DeleteAccountCheckCodeResponseModel {
  final bool success;

  const DeleteAccountCheckCodeResponseModel({
    required this.success,
  });

  factory DeleteAccountCheckCodeResponseModel.fromJson(
      Map<String, dynamic> json) {
    return DeleteAccountCheckCodeResponseModel(
      success: json['success'] ?? false,
    );
  }
}
