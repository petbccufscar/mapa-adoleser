// providers/register_provider.dart
import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/auth_service.dart';
import 'package:mapa_adoleser/domain/models/change_password_request_model.dart';
import 'package:mapa_adoleser/domain/models/check_current_password_response_model.dart';
import 'package:mapa_adoleser/domain/models/check_current_password_resquest_model.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _error;
  bool _loading = false;
  bool _success = false;

  String? get error => _error;
  bool get isLoading => _loading;
  bool get success => _success;

  Future<bool> checkCurrentPassword(String password) async {
    _loading = true;
    _error = null;
    _success = false;
    notifyListeners();

    try {
      final request = CheckCurrentPasswordRequestModel(password: password);

      await _authService.checkCurrentPassword(request);

      _success = true;
    } catch (e) {
      _error = parseException(e);
      _success = false;
    }

    _loading = false;
    notifyListeners();

    return true;
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    _loading = true;
    _error = null;
    _success = false;
    notifyListeners();

    try {
      final request = ChangePasswordRequestModel(
        password: currentPassword,
        newPassword: newPassword,
      );

      await _authService.changePassword(request);

      _success = true;
    } catch (e) {
      _error = parseException(e);
      _success = false;
    }

    _loading = false;
    notifyListeners();

    return true;
  }
}
