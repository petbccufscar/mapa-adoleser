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

  static String? isValidOTPCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Código obrigatório';
    }

    if (value.length != 6 || !RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'Código inválido';
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

  static String? isValidCep(String? cep) {
    if (cep == null || cep.trim().isEmpty) {
      return null;
    }

    final digits = cep.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length != 8) {
      return 'CEP deve ter 8 dígitos';
    }

    if (RegExp(r'^(\d)\1{7}$').hasMatch(digits)) {
      return 'CEP inválido';
    }

    return null; // válido
  }

  static String? isValidUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo é obrigatório';
    }
    if (value.isEmpty) {
      return 'Mínimo 1 caractere';
    }
    if (value.length > 150) {
      return 'Máximo 150 caracteres';
    }

    final regex = RegExp(r'^[\w.@+-]+$');
    if (!regex.hasMatch(value)) {
      return 'Formato inválido. Use apenas letras, números e . @ + - _';
    }

    return null; // válido
  }

  static String? passwordsMatch(String? value, String originalPassword,
      {String message = 'As senhas não coincidem'}) {
    if (value == null || value.isEmpty) return 'Confirme a senha';
    if (value != originalPassword) return message;
    return null;
  }

  static String? isValidDayMonthYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    final parts = value.split('/');
    if (parts.length != 3) return 'Data inválida';

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) return 'Data inválida';
    if (year < 1 || parts[2].length != 4) return 'Ano inválido';
    if (month < 1 || month > 12) return 'Mês inválido';

    // Verifica limite de dias de cada mês
    final List<int> daysInMonth = [
      31,
      (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))
          ? 29
          : 28, // fevereiro bissexto
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];

    if (day < 1 || day > daysInMonth[month - 1]) return 'Dia inválido';

    return null; // Data válida
  }
}
