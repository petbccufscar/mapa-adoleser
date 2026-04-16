class ContactRequestModel {
  final String name;
  final String email;
  final String message;
  final String subject;

  const ContactRequestModel({
    required this.name,
    required this.email,
    required this.message,
    required this.subject,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
    };
  }
}
