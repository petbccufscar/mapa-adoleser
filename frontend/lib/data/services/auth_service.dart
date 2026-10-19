import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mapa_adoleser/core/api_constants.dart';
import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/requests/change_password_request_model.dart';
import 'package:mapa_adoleser/domain/responses/change_password_response_model.dart';
import 'package:mapa_adoleser/domain/responses/check_current_password_response_model.dart';
import 'package:mapa_adoleser/domain/requests/check_current_password_resquest_model.dart';
import 'package:mapa_adoleser/domain/requests/forgot_password_check_code_request_model.dart';
import 'package:mapa_adoleser/domain/responses/forgot_password_check_code_response_model.dart';
import 'package:mapa_adoleser/domain/requests/forgot_password_email_request_model.dart';
import 'package:mapa_adoleser/domain/requests/login_request_model.dart';
import 'package:mapa_adoleser/domain/requests/register_request_model.dart';
import 'package:mapa_adoleser/domain/responses/forgot_password_email_response_model.dart';
import 'package:mapa_adoleser/domain/requests/reset_password_request_model.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';

class AuthService {
  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<UserModel> login(LoginRequestModel data) async {
    final response = await http.post(
      Uri.parse(ApiConstants.login),
      headers: _jsonHeaders,
      body: jsonEncode({
        'email': data.email,
        'password': data.password,
      }),
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return UserModel.fromLoginJson(body);
    } else if (response.statusCode == 401) {
      throw AuthException.fromJson(body, 'Usuário ou senha inválidos.');
    } else {
      throw FetchDataException.fromJson(
          body, 'Erro ao fazer login. Tente novamente.');
    }
  }

  Future<UserModel> register(RegisterRequestModel data) async {
    final response = await http.post(
      Uri.parse(ApiConstants.register),
      headers: _jsonHeaders,
      body: jsonEncode({
        'username': data.username,
        'email': data.email,
        'name': data.name,
        'birth_date': data.birthDate.toIso8601String().split('T').first,
        'password': data.password,
        'password2': data.password,
      }),
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 201) {
      // Após o registro, o backend não retorna tokens — fazemos login automaticamente.
      return await login(LoginRequestModel(
        email: data.email,
        password: data.password,
      ));
    } else {
      throw AuthException.fromJson(
          body, 'Erro ao criar conta. Verifique os dados e tente novamente.');
    }
  }

  Future<CheckCurrentPasswordResponseModel> changePasswordCheckCurrentPassword(
      CheckCurrentPasswordRequestModel data) async {
    // Esta verificação prévia não tem endpoint próprio no backend;
    // a validação da senha antiga ocorre em /api/password-change/ via old_password.
    return CheckCurrentPasswordResponseModel.fromJson({'valid': true});
  }

  Future<ChangePasswordResponseModel> changePasswordChangePassword(
      ChangePasswordRequestModel data,
      [String accessToken = '']) async {
    final response = await http.put(
      Uri.parse(ApiConstants.changePassword),
      headers: {
        ..._jsonHeaders,
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'old_password': data.password,
        'new_password': data.newPassword,
      }),
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return ChangePasswordResponseModel.fromJson({'success': true});
    } else {
      throw AuthException.fromJson(body, 'Não foi possível alterar a senha.');
    }
  }

  Future<ForgotPasswordEmailResponseModel?> recoveryPasswordSendOTPCode(
      ForgotPasswordEmailRequestModel data) async {
    final response = await http.post(
      Uri.parse(ApiConstants.passwordResetRequest),
      headers: _jsonHeaders,
      body: jsonEncode({'email': data.email}),
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return ForgotPasswordEmailResponseModel.fromJson({'success': true});
    } else {
      throw AuthException.fromJson(
          body, 'Erro ao solicitar código de recuperação.');
    }
  }

  Future<ForgotPasswordCheckCodeResponseModel?> recoveryPasswordCheckCode(
      ForgotPasswordCheckCodeRequestModel data) async {
    // O backend valida o código apenas em /password-reset/confirm/ junto com a nova senha.
    // Retornamos sucesso aqui; a validação real acontece em recoveryPasswordResetPassword.
    return ForgotPasswordCheckCodeResponseModel.fromJson({'success': true});
  }

  Future<void> recoveryPasswordResetPassword(
      ResetPasswordRequestModel request) async {
    final response = await http.post(
      Uri.parse(ApiConstants.passwordResetConfirm),
      headers: _jsonHeaders,
      body: jsonEncode({
        'email': request.email,
        'reset_code': request
            .password, // TODO: adicionar campo 'code' ao ResetPasswordRequestModel
        'new_password': request.password,
        'confirm_password': request.password,
      }),
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw AuthException.fromJson(body, 'Erro ao redefinir senha.');
    }
  }
}
