// providers/auth_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/auth_service.dart';
import 'package:mapa_adoleser/domain/models/forgot_password_email_request_model.dart';
import 'package:mapa_adoleser/domain/models/login_request_model.dart';
import 'package:mapa_adoleser/domain/models/register_request_model.dart';
import 'package:mapa_adoleser/domain/models/forgot_password_code_request_model.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;
  String? _error;
  bool _loading = false;
  bool _success = false;

  static const _userKey = 'user_data';

  UserModel? get user => _user;
  String? get error => _error;
  bool get isLoading => _loading;
  bool get isLoggedIn => _user != null;
  bool get success => _success;

  AuthProvider() {
    _loadUserFromStorage();
  }

  Future<void> login(String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final request = LoginRequestModel(email: email, password: password);
      _user = await _authService.login(request);

      await _saveUserToStorage(_user!);
    } catch (e) {
      _user = null;
      _error = parseException(e);
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> register(
      String email, String name, DateTime dateOfBirth, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final request = RegisterRequestModel(
        name: name,
        email: email,
        dateOfBirth: dateOfBirth,
        password: password,
      );

      _user = await _authService.register(request);

      await _saveUserToStorage(_user!);
    } catch (e) {
      _user = null;
      _error = parseException(e);
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> forgotPasswordEmail(
      String email) async {
    _loading = true;
    _error = null;
    _success = false;
    notifyListeners();

    try {
      final request = ForgotPasswordEmailRequestModel(
        email: email,
      );

      await _authService.forgotPasswordEmail(request);

      _success = true;
    } catch (e) {
      _success = false;
      _error = parseException(e);
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> forgotPasswordCode(
      String code) async {
    _loading = true;
    _error = null;
    _success = false;
    notifyListeners();

    try {
      final request = ForgotPasswordCodeRequestModel(
        code: code,
      );

      await _authService.forgotPasswordCode(request);

      _success = true;
    } catch (e) {
      _success = false;
      _error = parseException(e);
    }

    _loading = false;
    notifyListeners();
  }


  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);

    _user = null;
    _error = null;
    notifyListeners();
  }


  Future<void> _saveUserToStorage(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(user.toJson());

    await prefs.setString(_userKey, jsonData);
  }

  Future<void> _loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(_userKey);

    if (jsonData != null) {
      _user = UserModel.fromJson(jsonDecode(jsonData));
      notifyListeners();
    }
  }


}
