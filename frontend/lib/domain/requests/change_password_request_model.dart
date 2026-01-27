class ChangePasswordRequestModel {
  final String password;
  final String newPassword;

  const ChangePasswordRequestModel({
    required this.password,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'newPassword': newPassword,
    };
  }
}
