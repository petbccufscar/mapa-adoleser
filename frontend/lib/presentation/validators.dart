// lib/core/utils/validators.dart

class Validators {
  static String? isNotEmpty(String? value,
      {String message = 'Campo obrigatório'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? isEmail(String? value) {
    const pattern = r'^[\w\.\+\-]+@[a-zA-Z0-9\.\-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);

    if (value == null || value.trim().isEmpty) {
      return 'E-mail obrigatório';
    }
    if (!regex.hasMatch(value.trim())) {
      return 'E-mail inválido';
    }
    return null;
  }
}
