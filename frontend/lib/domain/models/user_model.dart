// lib/models/user_model.dart

class UserModel {
  final int id;
  final String name;
  final String email;
  final DateTime birthDate;
  final String role; // exemplo: admin, student, professor
  final String? avatarUrl;
  final String? token; // se for retornado no login

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.role,
    this.avatarUrl,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      birthDate: DateTime.parse(json['birthDate']),
      role: json['role'],
      avatarUrl: json['avatar_url'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'role': role,
      'avatar_url': avatarUrl,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, birthDate: ${birthDate.toIso8601String()}, role: $role, avatarUrl: $avatarUrl, token: $token}';
  }
}
