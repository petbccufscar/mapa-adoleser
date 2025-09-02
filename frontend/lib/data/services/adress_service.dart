import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mapa_adoleser/domain/models/adress_response_model.dart';

class AddressService {
  Future<AddressResponseModel> searchCEP(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AddressResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load address');
    }
  }
}
