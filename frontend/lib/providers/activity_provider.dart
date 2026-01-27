// providers/contact_provider.dart
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/activity_service.dart';
import 'package:mapa_adoleser/data/services/category_service.dart';
import 'package:mapa_adoleser/data/services/instance_service.dart';
import 'package:mapa_adoleser/data/services/review_service.dart';
import 'package:mapa_adoleser/domain/models/activity_model.dart';
import 'package:mapa_adoleser/domain/responses/activity_response_model.dart';
import 'package:mapa_adoleser/domain/responses/category_response_model.dart';
import 'package:mapa_adoleser/domain/responses/instece_activity_response_model.dart';
import 'package:mapa_adoleser/domain/responses/related_activity_response_model.dart';
import 'package:mapa_adoleser/domain/responses/review_response_model.dart';

class ActivityProvider extends ChangeNotifier {
  final ActivityService _activityService = ActivityService();
  final CategoryService _categoryService = CategoryService();
  final ReviewService _reviewService = ReviewService();
  final InstanceService _instanceService = InstanceService();

  String? _error;
  bool _loading = false;
  bool _success = false;
  ActivityModel? activity;

  bool get isLoading => _loading;
  String? get error => _error;
  bool get success => _success;

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
      ActivityResponseModel response =
          await _activityService.getActivityById(id);

      List<RelatedActivityResponseModel> related =
          await _activityService.getRelatedActivitiesById(id);

      List<CategoryResponseModel> categories =
          await _categoryService.getCategoriesByActivityId(id);

      List<ReviewResponseModel> reviews =
          await _reviewService.getReviewsByActivityId(id);

      List<InstanceActivityResponseModel> instances =
          await _instanceService.getInstancesByActivityId(id);

      activity = ActivityModel.fromResponse(response,
          categories: categories,
          reviews: reviews,
          instances: instances,
          related: related);
    } catch (e) {
      _error = parseException(e);
    }

    _loading = false;
    notifyListeners();
  }
}
