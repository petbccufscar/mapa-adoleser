class ChangePasswordResponseModel {
  final bool success;

  const ChangePasswordResponseModel({
    required this.success,
  });

  Map<String, dynamic> toJson() {
    return {
      'success': success,
    };
  }

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModel(
      success: json['success'],
    );
  }
}
