// providers/register_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;
  bool get isLoggedIn => _user != null;

  static const _userKey = 'user_data';

  AuthProvider() {
    _loadUserFromStorage();
  }

  void setUser(UserModel user) async {
    _user = user;

    _saveUserToStorage(user);

    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);

    _user = null;
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
