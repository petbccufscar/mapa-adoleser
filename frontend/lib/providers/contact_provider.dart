// providers/contact_provider.dart
import 'package:flutter/cupertino.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/contact_service.dart';
import 'package:mapa_adoleser/domain/models/contact_request_model.dart';
import 'package:mapa_adoleser/domain/models/subject_model.dart';

class ContactProvider extends ChangeNotifier {
  final ContactService _contactService = ContactService();

  String? _error;
  bool _loading = false;
  bool _success = false;
  List<SubjectModel> _subjects = [];

  ContactProvider() {
    getSubjects();
  }

  bool get isLoading => _loading;
  String? get error => _error;
  bool get success => _success;
  List<SubjectModel> get subjects => _subjects;

  Future<void> getSubjects() async {
    if (subjects.isNotEmpty) return;

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _subjects = await _contactService.fetchSubjects();
    } catch (e) {
      _error = parseException(e);
      _subjects = [];
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> sendContact(
      String email, String name, String subject, String message) async {
    _loading = true;
    _error = null;
    _success = false;
    notifyListeners();

    try {
      final request = ContactRequestModel(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );

      await _contactService.sendContact(request);

      _success = true;
    } catch (e) {
      _success = false;
      _error = parseException(e);
    }

    _loading = false;
    notifyListeners();
  }
}
