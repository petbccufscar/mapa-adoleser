import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapa_adoleser/core/api_constants.dart';
import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/responses/instance_response_model.dart';
import 'package:mapa_adoleser/domain/responses/instece_activity_response_model.dart';

class InstanceService {
  Future<InstanceResponseModel> getInstanceById(String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da instância não pode ser vazio');
    }

    final response = await http.get(Uri.parse(ApiConstants.instanceById(id)));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return InstanceResponseModel.fromJson(body);
    } else if (response.statusCode == 404) {
      throw FetchDataException('Instância não encontrada');
    } else {
      throw FetchDataException('Erro ao buscar a instância');
    }
  }

  Future<List<InstanceActivityResponseModel>> getInstancesByActivityId(String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da atividade não pode ser vazio');
    }

    final response = await http.get(Uri.parse('${ApiConstants.activityById(id)}instances/'));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => InstanceActivityResponseModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      throw FetchDataException('Atividade não encontrada');
    } else {
      throw FetchDataException('Erro ao buscar as instâncias da atividade');
    }
  }
}
