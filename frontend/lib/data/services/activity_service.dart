import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapa_adoleser/core/api_constants.dart';
import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/responses/activity_response_model.dart';
import 'package:mapa_adoleser/domain/responses/related_activity_response_model.dart';

class ActivityService {
  Future<ActivityResponseModel> getActivityById(String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da atividade não pode ser vazio');
    }

    final response = await http.get(Uri.parse(ApiConstants.activityById(id)));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return ActivityResponseModel.fromJson(body);
    } else if (response.statusCode == 404) {
      throw FetchDataException('Atividade não encontrada');
    } else {
      throw FetchDataException('Erro ao buscar a atividade');
    }
  }

  Future<List<RelatedActivityResponseModel>> getRelatedActivitiesById(
      String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da atividade não pode ser vazio');
    }

    final response = await http.get(Uri.parse('${ApiConstants.activityById(id)}related/'));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => RelatedActivityResponseModel.fromJson(json)).toList();
    } else {
      throw FetchDataException('Erro ao buscar as atividades relacionadas');
    }
  }

  Future<List<RelatedActivityResponseModel>> getActivitiesByInstanceId(
      String id) async {
    final response = await http.get(Uri.parse('${ApiConstants.instanceById(id)}activities/'));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => RelatedActivityResponseModel.fromJson(json)).toList();
    } else {
      throw FetchDataException('Erro ao buscar as atividades da instância');
    }
  }
}
