// lib/models/delete_account_check_code_request_model.dart

class DeleteAccountCheckCodeRequestModel {
  final String code;

  DeleteAccountCheckCodeRequestModel({
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}
