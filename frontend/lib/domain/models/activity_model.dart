import 'package:mapa_adoleser/domain/models/category_model.dart';
import 'package:mapa_adoleser/domain/models/instance_activity_model.dart';
import 'package:mapa_adoleser/domain/models/related_activity_model.dart';
import 'package:mapa_adoleser/domain/models/review_model.dart';
import 'package:mapa_adoleser/domain/responses/activity_response_model.dart';
import 'package:mapa_adoleser/domain/responses/category_response_model.dart';
import 'package:mapa_adoleser/domain/responses/instece_activity_response_model.dart';
import 'package:mapa_adoleser/domain/responses/related_activity_response_model.dart';
import 'package:mapa_adoleser/domain/responses/review_response_model.dart';

class ActivityModel {
  final String id;
  final String name;
  final String address;
  final String description;
  final String contact;

  final List<CategoryModel> categories;
  final List<ReviewModel> reviews;
  final List<InstanceActivityModel> instances;
  final List<RelatedActivityModel> related;

  final OperatingHours operatingHours;
  final AgeRange ageRange;

  final String accessibility;

  ActivityModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.contact,
    required this.categories,
    required this.operatingHours,
    required this.ageRange,
    required this.accessibility,
    required this.reviews,
    required this.instances,
    required this.related,
  });

  /// Mapper: ActivityResponseModel -> ActivityModel
  factory ActivityModel.fromResponse(ActivityResponseModel response,
      {List<RelatedActivityResponseModel> related = const [],
      List<CategoryResponseModel> categories = const [],
      List<ReviewResponseModel> reviews = const [],
      List<InstanceActivityResponseModel> instances = const []}) {
    final List<CategoryModel> categoryModels =
        categories.map<CategoryModel>(CategoryModel.fromResponse).toList();

    final List<RelatedActivityModel> realtedModels = related
        .map<RelatedActivityModel>(RelatedActivityModel.fromResponse)
        .toList();

    final List<ReviewModel> reviewModels =
        reviews.map<ReviewModel>(ReviewModel.fromResponse).toList();

    final List<InstanceActivityModel> instanceModels = instances
        .map<InstanceActivityModel>(InstanceActivityModel.fromResponse)
        .toList();

    return ActivityModel(
      id: response.id,
      name: response.name,
      address: response.address,
      description: response.description,
      contact: response.contact,
      categories: categoryModels,
      reviews: reviewModels,
      instances: instanceModels,
      related: realtedModels,
      operatingHours: OperatingHours(
        start: response.operatingStart,
        end: response.operatingEnd,
        days: response.operatingDays,
      ),
      ageRange: AgeRange(
        start: response.ageRangeStart,
        end: response.ageRangeEnd,
      ),
      accessibility: response.accessibility,
    );
  }
}

class OperatingHours {
  final String start;
  final String end;
  final List<String> days;

  OperatingHours({
    required this.start,
    required this.end,
    required this.days,
  });

  String get displayText => '${days.join(', ')} • $start - $end';
}

class AgeRange {
  final int start;
  final int end;

  AgeRange({
    required this.start,
    required this.end,
  });

  String get displayText => (start == 0 && end == 0)
      ? 'Para todas as idades'
      : 'De $start até $end anos';
}
