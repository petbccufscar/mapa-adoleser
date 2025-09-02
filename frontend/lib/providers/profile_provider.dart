// providers/register_provider.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/profile_service.dart';
import 'package:mapa_adoleser/domain/models/update_profile_request_model.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  String? _error;
  bool _loading = false;
  bool _success = false;

  String? get error => _error;
  bool get isLoading => _loading;
  bool get success => _success;

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<UserModel?> updateProfile(
      String name, DateTime birthDate, String cep) async {
    _loading = true;
    _error = null;
    _success = false;
    notifyListeners();

    UserModel? user;

    try {
      final request = UpdateProfileRequestModel(
        name: name,
        birthDate: birthDate,
        cep: cep,
      );
      user = await _profileService.updateProfile(request);

      _success = true;
    } catch (e) {
      _error = parseException(e);
      _success = false;
    }

    _loading = false;
    notifyListeners();

    return user;
  }
}
