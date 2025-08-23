class ContactResponse {
  final bool success;

  const ContactResponse({
    required this.success,
  });

  factory ContactResponse.fromJson(Map<String, dynamic> json) {
    return ContactResponse(
      success: json['success'] ?? false,
    );
  }
}
