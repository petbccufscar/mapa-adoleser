/// Contém as constantes relacionadas à API do backend.
class ApiConstants {
  ApiConstants._(); // Construtor privado para evitar instância

  static const String baseUrl = 'http://localhost:8000';

  // Endpoints de autenticação
  static const String login = '$baseUrl/api/login/';
  static const String register = '$baseUrl/api/register/';
  static const String logout = '$baseUrl/api/logout/';
  static const String refreshToken = '$baseUrl/api/login/refresh/';
  static const String profile = '$baseUrl/api/profile/';
  static const String changePassword = '$baseUrl/api/password-change/';
  static const String passwordResetRequest = '$baseUrl/api/password-reset/request/';
  static const String passwordResetConfirm = '$baseUrl/api/password-reset/confirm/';

  // Endpoints de atividades
  static const String activities = '$baseUrl/api/activities/';
  static String activityById(String id) => '$baseUrl/api/activities/$id/';

  // Endpoints de instâncias
  static const String instances = '$baseUrl/api/instances/';
  static String instanceById(String id) => '$baseUrl/api/instances/$id/';
}
