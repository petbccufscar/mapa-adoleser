import 'package:flutter/material.dart';

/// Widget customizado de campo de texto, possivelmente com estilos e validações personalizados.

class CustomTextField extends StatelessWidget {
  final String label; // Label do input
  final String? hint; // Placeholder o input
  final TextEditingController controller;  // Controler para digitação
  final TextInputType keyboardType; // Tipo de input
  final bool obscureText; // Bool para esconder o texto
  final String? Function(String?)? validator; // Validação do campo
  final IconData? icon; // Ícone a esquerda

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Text para renderizar label
      Text(
        label,
        style: Theme.of(context).textTheme.labelMedium
      ),
      const SizedBox(height: 5),
      // Input
      TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon != null ? Icon(icon) : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)
        ),
      )
    ]);
  }
}
