class DeleteAccountResponseModel {
  final bool success;

  const DeleteAccountResponseModel({
    required this.success,
  });

  factory DeleteAccountResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteAccountResponseModel(
      success: json['success'] ?? false,
    );
  }
}
