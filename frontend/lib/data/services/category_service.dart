import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapa_adoleser/core/api_constants.dart';
import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/responses/category_response_model.dart';

class CategoryService {
  Future<List<CategoryResponseModel>> getCategoriesByActivityId(String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da atividade não pode ser vazio');
    }

    final response = await http.get(Uri.parse('${ApiConstants.activityById(id)}categories/'));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => CategoryResponseModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      throw FetchDataException('Atividade não encontrada');
    } else {
      throw FetchDataException('Erro ao buscar as categorias');
    }
  }

  Future<List<CategoryResponseModel>> getCategoriesByInstanceId(String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da instância não pode ser vazio');
    }

    final response = await http.get(Uri.parse('${ApiConstants.instanceById(id)}categories/'));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => CategoryResponseModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      throw FetchDataException('Instância não encontrada');
    } else {
      throw FetchDataException('Erro ao buscar as categorias');
    }
  }
}
