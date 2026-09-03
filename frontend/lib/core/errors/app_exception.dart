// lib/core/errors/app_exception.dart

abstract class AppException implements Exception {
  final String message;

  AppException(this.message);

  AppException.fromJson(Map<String, dynamic> json, String fallback)
      : message = _extract(json, fallback);

  static String _extract(Map<String, dynamic> json, String fallback) {
    for (final value in json.values) {
      if (value is String) return value;
      if (value is List && value.isNotEmpty) return value.first.toString();
    }
    return fallback;
  }

  @override
  String toString() => message;
}

class InvalidParameterException extends AppException {
  InvalidParameterException([super.message = 'Parâmetro inválido']);
}

class FetchDataException extends AppException {
  FetchDataException(super.message);
  FetchDataException.fromJson(super.json, super.fallback) : super.fromJson();
}

class ContactException extends AppException {
  ContactException(super.message);
  ContactException.fromJson(super.json, super.fallback) : super.fromJson();
}

class AuthException extends AppException {
  AuthException(super.message);
  AuthException.fromJson(super.json, super.fallback) : super.fromJson();
}

class NetworkException extends AppException {
  NetworkException(super.message);
  NetworkException.fromJson(super.json, super.fallback) : super.fromJson();
}

class ServerException extends AppException {
  ServerException(super.message);
  ServerException.fromJson(super.json, super.fallback) : super.fromJson();
}

class ValidationException extends AppException {
  ValidationException(super.message);
  ValidationException.fromJson(super.json, super.fallback) : super.fromJson();
}
