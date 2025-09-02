// lib/core/errors/app_exception.dart

abstract class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class ContactException extends AppException {
  ContactException([super.message = 'Erro ao enviar seu contato :(']);
}

class AuthException extends AppException {
  AuthException(super.message);
}

class NetworkException extends AppException {
  NetworkException([super.message = 'Problema de conexão']);
}

class ServerException extends AppException {
  ServerException([super.message = 'Erro no servidor']);
}

class ValidationException extends AppException {
  ValidationException(super.message);
}
