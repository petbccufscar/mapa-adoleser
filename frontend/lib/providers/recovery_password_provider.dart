import 'package:flutter/widgets.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/auth_service.dart';
import 'package:mapa_adoleser/domain/requests/forgot_password_check_code_request_model.dart';
import 'package:mapa_adoleser/domain/requests/forgot_password_email_request_model.dart';
import 'package:mapa_adoleser/domain/requests/reset_password_request_model.dart';

class RecoveryPasswordProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _error;
  bool _loading = false;

  String? get error => _error;
  bool get isLoading => _loading;

  Future<void> sendOTPCode(String email) async {
    _loading = true;
    _error = null;

    notifyListeners();

    try {
      final request = ForgotPasswordEmailRequestModel(
        email: email,
      );

      await _authService.recoveryPasswordSendOTPCode(request);
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
      final request = ForgotPasswordCheckCodeRequestModel(
        code: code,
      );

      await _authService.recoveryPasswordCheckCode(request);
    } catch (e) {
      _error = parseException(e);
    }

    _loading = false;

    notifyListeners();
  }

  Future<void> resetPassword(String email, String password) async {
    _loading = true;
    _error = null;

    notifyListeners();

    try {
      final request = ResetPasswordRequestModel(
        email: email,
        password: password,
      );

      await _authService.recoveryPasswordResetPassword(request);
    } catch (e) {
      _error = parseException(e);
    }

    _loading = false;

    notifyListeners();
  }
}
