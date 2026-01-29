import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/requests/delete_account_check_account_request_model.dart';
import 'package:mapa_adoleser/domain/responses/delete_account_check_account_response_model.dart';
import 'package:mapa_adoleser/domain/requests/delete_account_check_code_request_model.dart';
import 'package:mapa_adoleser/domain/responses/delete_account_check_code_response_model.dart';
import 'package:mapa_adoleser/domain/requests/update_profile_request_model.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';
import 'package:mapa_adoleser/domain/responses/delete_account_response_model.dart';

class ProfileService {
  Future<UserModel> updateProfile(UpdateProfileRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

    if (data.name == 'errado') {
      throw ServerException('Erro ao atualizar perfil!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'id': 1,
      'name': data.name,
      'username': 'coutrims',
      'email': 'vini.cotrim@hotmail.com',
      'birthDate': data.birthDate.toIso8601String(),
      'role': 'admin',
      'avatar_url': null,
      'token': 'abc.def.ghi',
    };

    return UserModel.fromJson(mockResponse);
  }

  Future<DeleteAccountCheckAccountResponseModel?> deleteAccountSendOTPCode(
      DeleteAccountCheckAccountRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2));

    if (data.email == "aaa@gmail.com") {
      throw AuthException('E-mail ou senha incorretos!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'success': true,
    };

    return DeleteAccountCheckAccountResponseModel.fromJson(mockResponse);
  }

  Future<DeleteAccountCheckCodeResponseModel?> deleteAccountCheckCode(
      DeleteAccountCheckCodeRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2));

    if (data.code != "123456") {
      throw AuthException('Código inválido ou expirado!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'success': true,
    };

    return DeleteAccountCheckCodeResponseModel.fromJson(mockResponse);
  }

  Future<DeleteAccountResponseModel?> deleteAccount(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    if (id != "123456") {
      throw AuthException('Erro ao excluir a conta!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'success': true,
    };

    return DeleteAccountResponseModel.fromJson(mockResponse);
  }
}
