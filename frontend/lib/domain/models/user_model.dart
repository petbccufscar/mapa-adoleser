// lib/models/user_model.dart

class UserModel {
  final int id;
  final String username;
  final String name;
  final String email;
  final DateTime birthDate;
  final String cep;
  final String? avatarUrl;
  final String? token; // se for retornado no login

  UserModel({
    required this.username,
    required this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.cep,
    this.avatarUrl,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      cep: json['cep'] ?? '',
      birthDate: DateTime.parse(json['birthDate']),
      avatarUrl: json['avatar_url'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'cep': cep,
      'avatar_url': avatarUrl,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, name: $name, email: $email, birthDate: ${birthDate.toIso8601String()}, avatarUrl: $avatarUrl, token: $token}';
  }
}
