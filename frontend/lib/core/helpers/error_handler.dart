// lib/core/helpers/error_handler.dart
import '../errors/app_exception.dart';

String parseException(Object error) {
  if (error is AppException) return error.message;

  return 'Erro desconhecido';
}
