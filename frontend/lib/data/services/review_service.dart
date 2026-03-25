import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapa_adoleser/core/api_constants.dart';
import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/responses/review_response_model.dart';

class ReviewService {
  Future<List<ReviewResponseModel>> getReviewsByActivityId(String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da atividade não pode ser vazio');
    }

    final response = await http.get(Uri.parse('${ApiConstants.activityById(id)}reviews/'));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => ReviewResponseModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      throw FetchDataException('Atividade não encontrada');
    } else {
      throw FetchDataException('Erro ao buscar as avaliações');
    }
  }

  Future<List<ReviewResponseModel>> getReviewsByInstanceId(String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da instância não pode ser vazio');
    }

    final response = await http.get(Uri.parse('${ApiConstants.instanceById(id)}reviews/'));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => ReviewResponseModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      throw FetchDataException('Instância não encontrada');
    } else {
      throw FetchDataException('Erro ao buscar as avaliações');
    }
  }
}
