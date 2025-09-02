import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mapa_adoleser/domain/models/address_response_model.dart';

class AddressService {
  Future<AddressResponseModel> searchCEP(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final response = await http.get(url);

    log('Response Body: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      return AddressResponseModel.fromJson(jsonDecode(response.body));
    }

    throw Exception('CEP não encontrado');
  }
}
