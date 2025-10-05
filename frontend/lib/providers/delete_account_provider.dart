// providers/register_provider.dart
import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/auth_service.dart';

class DeleteAccountProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

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

  Future<bool> sendOTPCode(String email) async {
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

  Future<bool> checkOTPCode(String code) async {
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

  Future<bool> deleteAccount(String code) async {
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
}
