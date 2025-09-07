import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/models/change_password_request_model.dart';
import 'package:mapa_adoleser/domain/models/change_password_response_model.dart';
import 'package:mapa_adoleser/domain/models/check_current_password_response_model.dart';
import 'package:mapa_adoleser/domain/models/check_current_password_resquest_model.dart';
import 'package:mapa_adoleser/domain/models/forgot_password_code_request_model.dart';
import 'package:mapa_adoleser/domain/models/forgot_password_code_response_model.dart';
import 'package:mapa_adoleser/domain/models/forgot_password_email_request_model.dart';
import 'package:mapa_adoleser/domain/models/login_request_model.dart';
import 'package:mapa_adoleser/domain/models/register_request_model.dart';
import 'package:mapa_adoleser/domain/models/forgot_password_email_response_model.dart';
import 'package:mapa_adoleser/domain/models/reset_password_request_model.dart';
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

  Future<CheckCurrentPasswordResponseModel> checkCurrentPassword(
      CheckCurrentPasswordRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

    if (data.password != '123') {
      throw AuthException('A senha digitada está incorreta!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'valid': true,
    };

    if (!mockResponse['valid']!) {
      throw AuthException('Senha incorreta!');
    }

    return CheckCurrentPasswordResponseModel.fromJson(mockResponse);
  }

  Future<ChangePasswordResponseModel> changePassword(
      ChangePasswordRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

    if (data.newPassword == 'coutrims1!') {
      throw AuthException('Sua nova senha não pode ser igual a anterior!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'success': true,
    };

    if (!mockResponse['success']!) {
      throw AuthException('Não foi possível alterar a senha!');
    }

    return ChangePasswordResponseModel.fromJson(mockResponse);
  }

  Future<ForgotPasswordEmailResponseModel?> forgotPasswordEmail(
      ForgotPasswordEmailRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2));

    if (data.email == "fulanodetal@gmail.com") {
      throw AuthException('Nenhuma conta vinculada a este e-mail');
    }

    // Simulando resposta da API
    final mockResponse = {
      'success': true,
    };

    return ForgotPasswordEmailResponseModel.fromJson(mockResponse);
  }

  Future<ForgotPasswordCodeResponseModel?> forgotPasswordCode(
      ForgotPasswordCodeRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2));

    if (data.code != "123456") {
      throw AuthException('Código inválido ou expirado!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'success': true,
    };

    return ForgotPasswordCodeResponseModel.fromJson(mockResponse);
  }

  Future<void> resetPassword(ResetPasswordRequestModel request) async {
    await Future.delayed(const Duration(seconds: 2));

    if (request.password == "coutrims1!") {
      throw AuthException('A nova senha não pode ser igual à anterior!');
    }

    return;
  }
}
