class CheckCurrentPasswordRequestModel {
  final String password;

  const CheckCurrentPasswordRequestModel({
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
    };
  }

  factory CheckCurrentPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return CheckCurrentPasswordRequestModel(
      password: json['password'],
    );
  }
}
