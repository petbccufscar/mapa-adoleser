import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mapa_adoleser/domain/responses/address_response_model.dart';

class AddressService {
  Future<AddressResponseModel> searchCEP(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final response = await http.get(url);

    final data = json.decode(response.body) as Map<String, dynamic>;

    log(data.toString());

    if (response.statusCode != 200 || data['erro'].toString() == "true") {
      throw Exception('CEP não encontrado');
    }

    return AddressResponseModel.fromJson(jsonDecode(response.body));
  }
}
