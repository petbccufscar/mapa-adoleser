class DeleteAccountCheckAccountResponseModel {
  final bool success;

  const DeleteAccountCheckAccountResponseModel({
    required this.success,
  });

  factory DeleteAccountCheckAccountResponseModel.fromJson(
      Map<String, dynamic> json) {
    return DeleteAccountCheckAccountResponseModel(
      success: json['success'] ?? false,
    );
  }
}
