// providers/contact_provider.dart
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/activity_service.dart';
import 'package:mapa_adoleser/domain/models/activity_model.dart';
import 'package:mapa_adoleser/domain/models/subject_model.dart';
import 'package:mapa_adoleser/domain/models/activity_response_model.dart';

class ActivityProvider extends ChangeNotifier {
  final ActivityService _activityService = ActivityService();

  String? _error;
  bool _loading = false;
  bool _success = false;
  List<SubjectModel> _subjects = [];
  ActivityModel? activity;

  bool get isLoading => _loading;
  String? get error => _error;
  bool get success => _success;
  List<SubjectModel> get subjects => _subjects;

  @override
  void dispose() {
    log('Provider descartado para id: ${activity?.id}');
    super.dispose();
  }

  Future<void> getActivityById(String id) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      ActivityModel response =
          await _activityService.getActivityById(id);

      this.activity = ActivityModel(
        id: activity.id,
        locationId: activity.locationId,
        name: activity.name,
        description: activity.description,
        date: activity.date,
      );
    } catch (e) {
      _error = parseException(e);
      _subjects = [];
    }

    _loading = false;
    notifyListeners();
  }

  // Future<void> sendContact(
  //     String email, String name, String subject, String message) async {
  //   _loading = true;
  //   _error = null;
  //   _success = false;
  //   notifyListeners();

  //   try {
  //     final request = ContactRequestModel(
  //       name: name,
  //       email: email,
  //       subject: subject,
  //       message: message,
  //     );

  //     await _activityService.sendContact(request);

  //     _success = true;
  //   } catch (e) {
  //     _success = false;
  //     _error = parseException(e);
  //   }

  //   _loading = false;
  //   notifyListeners();
  // }
}
