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

  static String? isValidPassword(
    String? value, {
    int minLength = 8,
    bool requireSpecialChar = true,
    bool requireUppercase = false,
    bool requireNumber = true,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Senha obrigatória';
    }

    if (value.length < minLength) {
      return 'Senha deve ter no mínimo $minLength caracteres';
    }

    if (requireSpecialChar &&
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Inclua ao menos um caractere especial';
    }

    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Inclua ao menos uma letra maiúscula';
    }

    if (requireNumber && !RegExp(r'[0-9]').hasMatch(value)) {
      return 'Inclua ao menos um número';
    }

    return null;
  }

  static String? passwordsMatch(String? value, String originalPassword,
      {String message = 'As senhas não coincidem'}) {
    if (value == null || value.isEmpty) return 'Confirme a senha';
    if (value != originalPassword) return message;
    return null;
  }
}
