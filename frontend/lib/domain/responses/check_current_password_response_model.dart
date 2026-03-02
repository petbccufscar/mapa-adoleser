class CheckCurrentPasswordResponseModel {
  final bool valid;

  const CheckCurrentPasswordResponseModel({
    required this.valid,
  });

  factory CheckCurrentPasswordResponseModel.fromJson(
      Map<String, dynamic> json) {
    return CheckCurrentPasswordResponseModel(
      valid: json['valid'] ?? false,
    );
  }
}
