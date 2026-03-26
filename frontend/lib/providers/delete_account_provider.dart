// providers/register_provider.dart
import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/profile_service.dart';
import 'package:mapa_adoleser/domain/requests/delete_account_check_account_request_model.dart';
import 'package:mapa_adoleser/domain/requests/delete_account_check_code_request_model.dart';
import 'package:mapa_adoleser/domain/responses/delete_account_response_model.dart';

class DeleteAccountProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  String? _error;
  bool _loading = false;

  String? get error => _error;
  bool get isLoading => _loading;

  Future<bool> checkAccount(String email, String password) async {
    _loading = true;
    _error = null;

    notifyListeners();

    //CheckCurrentPasswordResponseModel? result;

    try {
      //final request = CheckCurrentPasswordRequestModel(password: password);

      //result = await _authService.checkCurrentPassword(request);
    } catch (e) {
      _error = parseException(e);
    }

    _loading = false;

    notifyListeners();

    //return result?.valid ?? false;

    return true;
  }

  Future<void> sendOTPCode(String email, String password) async {
    _loading = true;
    _error = null;

    notifyListeners();

    try {
      final request = DeleteAccountCheckAccountRequestModel(
          email: email, password: password);

      await _profileService.deleteAccountSendOTPCode(request);
    } catch (e) {
      _error = parseException(e);
    }

    _loading = false;

    notifyListeners();
  }

  Future<void> checkOTPCode(String code) async {
    _loading = true;
    _error = null;

    notifyListeners();

    try {
      final request = DeleteAccountCheckCodeRequestModel(
        code: code,
      );

      await _profileService.deleteAccountCheckCode(request);
    } catch (e) {
      _error = parseException(e);
    }

    _loading = false;

    notifyListeners();
  }

  Future<bool> deleteAccount(String id) async {
    _loading = true;
    _error = null;

    notifyListeners();

    DeleteAccountResponseModel? result;

    try {
      result = await _profileService.deleteAccount(id);
    } catch (e) {
      _error = parseException(e);
    }

    _loading = false;

    notifyListeners();

    result?.success ?? false;
  }
}
