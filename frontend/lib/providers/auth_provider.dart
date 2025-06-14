// providers/auth_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mapa_adoleser/data/services/auth_service.dart';
import 'package:mapa_adoleser/domain/models/login_request_model.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/helpers/error_handler.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;
  String? _error;
  bool _loading = false;

  static const _userKey = 'user_data';

  UserModel? get user => _user;
  String? get error => _error;
  bool get isLoading => _loading;
  bool get isLoggedIn => _user != null;

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
