import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/models/login_request_model.dart';
import 'package:mapa_adoleser/domain/models/register_request_model.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';

class AuthService {
  Future<UserModel> login(LoginRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

    if (data.email != 'admin@example.com') {
      throw AuthException('E-mail não encontrado!');
    }

    if (data.password != '123') {
      throw AuthException('Senha incorreta!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'id': 1,
      'name': 'Admin',
      'email': data.email,
      'dateOfBirth': '2025-08-11T01:37:16.936',
      'role': 'admin',
      'avatar_url': null,
      'token': 'abc.def.ghi',
    };

    return UserModel.fromJson(mockResponse);
  }

  Future<UserModel> register(RegisterRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

    if (data.email == 'usado@example.com') {
      throw AuthException('E-mail já está em uso!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'id': 1,
      'email': data.email,
      'name': data.name,
      'dateOfBirth': data.dateOfBirth.toIso8601String(),
      'role': 'admin',
      'avatar_url': null,
      'token': 'abc.def.ghi',
    };

    return UserModel.fromJson(mockResponse);
  }
}
