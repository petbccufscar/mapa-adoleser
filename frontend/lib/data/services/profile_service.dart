import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapa_adoleser/core/api_constants.dart';

import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/requests/delete_account_check_account_request_model.dart';
import 'package:mapa_adoleser/domain/responses/delete_account_check_account_response_model.dart';
import 'package:mapa_adoleser/domain/requests/delete_account_check_code_request_model.dart';
import 'package:mapa_adoleser/domain/responses/delete_account_check_code_response_model.dart';
import 'package:mapa_adoleser/domain/requests/update_profile_request_model.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';
import 'package:mapa_adoleser/domain/responses/delete_account_response_model.dart';

class ProfileService {
  Future<UserModel> updateProfile(UpdateProfileRequestModel data, [String accessToken = '']) async {
    final response = await http.patch(
      Uri.parse(ApiConstants.profile),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'name': data.name,
        'birth_date': data.birthDate.toIso8601String().split('T').first,
      }),
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(responseBody);
    } else {
      throw ServerException('Erro ao atualizar perfil!');
    }
  }

  Future<DeleteAccountCheckAccountResponseModel?> deleteAccountSendOTPCode(
      DeleteAccountCheckAccountRequestModel data) async {
    // Mock valid until OTP delete is implemented on backend
    return DeleteAccountCheckAccountResponseModel.fromJson({'success': true});
  }

  Future<DeleteAccountCheckCodeResponseModel?> deleteAccountCheckCode(
      DeleteAccountCheckCodeRequestModel data) async {
    // Mock valid until OTP delete is implemented on backend
    return DeleteAccountCheckCodeResponseModel.fromJson({'success': true});
  }

  Future<DeleteAccountResponseModel?> deleteAccount(String id, [String accessToken = '']) async {
    final response = await http.delete(
      Uri.parse(ApiConstants.profile),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 204) {
      return DeleteAccountResponseModel.fromJson({'success': true});
    } else {
      throw AuthException('Erro ao excluir a conta!');
    }
  }
}
