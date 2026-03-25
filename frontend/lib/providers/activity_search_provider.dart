import 'package:flutter/material.dart';
import 'package:mapa_adoleser/data/services/activity_service.dart';
import 'package:mapa_adoleser/domain/models/activity_model.dart';
import 'package:mapa_adoleser/domain/responses/activity_response_model.dart';

class ActivitySearchProvider extends ChangeNotifier {
  final ActivityService _activityService = ActivityService();

  List<ActivityModel> _activities = [];
  bool _isLoading = false;
  String? _error;
  ActivityModel? _selectedActivity;

  // Filters
  String _searchQuery = '';
  String _cep = '';
  String _category = '';
  String _period = '';
  String _targetAge = '';

  List<ActivityModel> get activities => _activities;
  bool get isLoading => _isLoading;
  String? get error => _error;
  ActivityModel? get selectedActivity => _selectedActivity;

  String get searchQuery => _searchQuery;
  String get cep => _cep;
  String get category => _category;
  String get period => _period;
  String get targetAge => _targetAge;

  void setFilters({
    String? search,
    String? cep,
    String? category,
    String? period,
    String? targetAge,
  }) {
    if (search != null) _searchQuery = search;
    if (cep != null) _cep = cep;
    if (category != null) _category = category;
    if (period != null) _period = period;
    if (targetAge != null) _targetAge = targetAge;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _cep = '';
    _category = '';
    _period = '';
    _targetAge = '';
    notifyListeners();
    searchActivities(); // Fetch all again
  }
  
  void selectActivity(ActivityModel activity) {
    _selectedActivity = activity;
    notifyListeners();
  }

  Future<void> searchActivities() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      Map<String, String> filters = {};
      if (_searchQuery.isNotEmpty) filters['search'] = _searchQuery;
      if (_cep.isNotEmpty) filters['cep'] = _cep; 
      if (_category.isNotEmpty) filters['category'] = _category;
      if (_period.isNotEmpty) filters['period'] = _period;
      if (_targetAge.isNotEmpty) filters['target_age'] = _targetAge;

      List<ActivityResponseModel> responses =
          await _activityService.getActivities(filters: filters);
      
      _activities = responses.map((r) => ActivityModel.fromResponse(r)).toList();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
