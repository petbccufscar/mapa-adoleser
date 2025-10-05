// providers/register_provider.dart
import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/auth_service.dart';
import 'package:mapa_adoleser/domain/models/change_password_request_model.dart';
import 'package:mapa_adoleser/domain/models/change_password_response_model.dart';
import 'package:mapa_adoleser/domain/models/check_current_password_response_model.dart';
import 'package:mapa_adoleser/domain/models/check_current_password_resquest_model.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _error;
  bool _loading = false;

  String? get error => _error;
  bool get isLoading => _loading;

  Future<bool> checkCurrentPassword(String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    CheckCurrentPasswordResponseModel? result;

    try {
      final request = CheckCurrentPasswordRequestModel(password: password);

      result = await _authService.changePasswordCheckCurrentPassword(request);
    } catch (e) {
      _error = parseException(e);
    }

    _loading = false;

    notifyListeners();

    return result?.valid ?? false;
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    _loading = true;
    _error = null;

    notifyListeners();

    ChangePasswordResponseModel? result;

    try {
      final request = ChangePasswordRequestModel(
        password: currentPassword,
        newPassword: newPassword,
      );

      result = await _authService.changePasswordChangePassword(request);
    } catch (e) {
      _error = parseException(e);
    }

    _loading = false;

    notifyListeners();

    return result?.success ?? false;
  }
}
