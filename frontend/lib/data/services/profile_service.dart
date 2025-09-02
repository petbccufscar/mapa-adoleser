import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/models/update_profile_request_model.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';

class ProfileService {
  Future<UserModel> updateProfile(UpdateProfileRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

    if (data.name == 'errado') {
      throw ServerException('Erro ao atualizar perfil!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'id': 1,
      'name': data.name,
      'username': 'coutrims',
      'email': 'vini.cotrim@hotmail.com',
      'birthDate': data.birthDate.toIso8601String(),
      'cep': data.cep,
      'role': 'admin',
      'avatar_url': null,
      'token': 'abc.def.ghi',
    };

    return UserModel.fromJson(mockResponse);
  }
}
