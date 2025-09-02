// providers/register_provider.dart
import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/auth_service.dart';
import 'package:mapa_adoleser/domain/models/register_request_model.dart';

class RegisterProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _error;
  bool _loading = false;
  bool _success = false;

  String? get error => _error;
  bool get isLoading => _loading;
  bool get success => _success;

  Future<void> register(String email, String username, String name,
      DateTime birthDate, String password, bool acceptTerms) async {
    _loading = true;
    _error = null;
    _success = false;
    notifyListeners();

    if (!acceptTerms) {
      _loading = false;
      _error =
          "Você precisa concordar com os Termos de Uso e Políticas de Privacidade";
      notifyListeners();
      return;
    }

    try {
      final request = RegisterRequestModel(
        name: name,
        username: username,
        email: email,
        birthDate: birthDate,
        password: password,
      );

      await _authService.register(request);

      _success = true;
    } catch (e) {
      _error = parseException(e);
      _success = false;
    }

    _loading = false;
    notifyListeners();
  }
}
