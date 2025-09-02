import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/models/login_request_model.dart';
import 'package:mapa_adoleser/domain/models/register_request_model.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';

class AuthService {
  Future<UserModel> login(LoginRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

    if (data.username != 'coutrims') {
      throw AuthException('Usuário não encontrado!');
    }

    if (data.password != '123') {
      throw AuthException('Senha incorreta!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'id': 1,
      'name': 'Vinícius Martins Cotrim',
      'username': data.username,
      'email': 'vini.cotrim@hotmail.com',
      'birthDate': '2025-08-11T01:37:16.936',
      'cep': '13180-220',
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
      'username': data.username,
      'name': data.name,
      'birthDate': data.birthDate.toIso8601String(),
      'role': 'admin',
      'avatar_url': null,
      'token': 'abc.def.ghi',
    };

    return UserModel.fromJson(mockResponse);
  }
}
