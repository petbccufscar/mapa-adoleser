import 'package:mapa_adoleser/domain/models/user_model.dart';

import '../../core/errors/app_exception.dart';
import '../../domain/models/login_request_model.dart';

class AuthService {
  Future<UserModel> login(LoginRequestModel data) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

      if (data.email != 'admin@example.com') {
      throw AuthException('E-mail não encontrado!');
    }

    if (data.password != '123') {
      throw AuthException('Senha incorreta!');
    }

    // Simulando resposta da API
    final mockResponse = {
      'id': 1,
      'name': 'Admin',
      'email': data.email,
      'role': 'admin',
      'avatar_url': null,
      'token': 'abc.def.ghi',
    };

    return UserModel.fromJson(mockResponse);
  }
}
