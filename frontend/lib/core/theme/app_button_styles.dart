import 'package:flutter/material.dart';

class AppButtonStyles {
  /// Estilo padrão — texto centralizado, padding equilibrado.
  static final ButtonStyle centered = ElevatedButton.styleFrom(
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    alignment: Alignment.center, // 👈 centraliza o texto
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  /// Estilo para botões com ícones — texto e ícone alinhados à esquerda.
  static final ButtonStyle withIcon = ElevatedButton.styleFrom(
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    alignment: Alignment.centerLeft, // 👈 alinha à esquerda
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
