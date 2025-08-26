import 'package:via_cep_flutter/via_cep_flutter.dart';
import 'package:mapa_adoleser/domain/models/contact_response_model.dart';

class AdressService {
  Future<ContactResponse> searchCEP(String cep) async {
    final result = await readAddressByCep('49328555'); //Cep inválido!

    if (result.isEmpty) return;

    // Simula sucesso
    return const ContactResponse(success: true);
  }
}
