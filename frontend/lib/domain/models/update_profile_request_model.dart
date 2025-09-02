// lib/models/register_request_model.dart

class UpdateProfileRequestModel {
  final String name;
  final DateTime birthDate;
  final String cep;

  UpdateProfileRequestModel({
    required this.name,
    required this.birthDate,
    required this.cep,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthDate': birthDate.toIso8601String(),
      'cep': cep,
    };
  }
}
