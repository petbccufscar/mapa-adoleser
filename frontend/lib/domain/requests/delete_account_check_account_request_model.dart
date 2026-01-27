// lib/models/delete_account_check_account_request_model.dart

class DeleteAccountCheckAccountRequestModel {
  final String email;
  final String password;

  DeleteAccountCheckAccountRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
