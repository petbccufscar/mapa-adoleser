class ContactResponseModel {
  final bool success;

  const ContactResponseModel({
    required this.success,
  });

  factory ContactResponseModel.fromJson(Map<String, dynamic> json) {
    return ContactResponseModel(
      success: json['success'] ?? false,
    );
  }
}
