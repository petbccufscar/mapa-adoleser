// lib/models/user_model.dart

class UserModel {
  final int id;
  final String username;
  final String name;
  final String email;
  final DateTime birthDate;
  final String? avatarUrl;
  final String? accessToken;
  final String? refreshToken;

  UserModel({
    required this.username,
    required this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    this.avatarUrl,
    this.accessToken,
    this.refreshToken,
  });

  /// Cria um UserModel a partir do JSON retornado pelo endpoint de login.
  /// Espera a estrutura: { "access": "...", "refresh": "...", "user": { ... } }
  factory UserModel.fromLoginJson(Map<String, dynamic> json) {
    final userData = json['user'] as Map<String, dynamic>;
    return UserModel(
      id: userData['id'],
      username: userData['username'] ?? '',
      name: userData['name'] ?? '',
      email: userData['email'] ?? '',
      birthDate: DateTime.parse(userData['birth_date'] ?? userData['birthDate'] ?? '1970-01-01'),
      avatarUrl: userData['avatar_url'],
      accessToken: json['access'],
      refreshToken: json['refresh'],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      birthDate: DateTime.parse(json['birth_date'] ?? json['birthDate'] ?? '1970-01-01'),
      avatarUrl: json['avatar_url'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'avatar_url': avatarUrl,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, name: $name, email: $email, birthDate: ${birthDate.toIso8601String()}, avatarUrl: $avatarUrl}';
  }
}
