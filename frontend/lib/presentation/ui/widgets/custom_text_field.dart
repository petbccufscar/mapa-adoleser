import 'package:flutter/material.dart';

/// Widget customizado de campo de texto, possivelmente com estilos e validações personalizados.

class CustomTextField extends StatelessWidget {
  final String label; // Label do input
  final String? hint; // Placeholder o input
  final int maxLines;
  final TextInputType keyboardType; // Tipo de input
  final String? Function(String?)? validator; // Validação do campo
  final void Function(String)? onFieldSubmitted;
  final IconData? icon; // Ícone a esquerda
  final TextInputAction? textInputAction;
  final TextEditingController controller; // Controler para digitação

  const CustomTextField({
    super.key,
    this.maxLines = 1,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.icon,
    this.onFieldSubmitted,
    this.textInputAction,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Text para renderizar label
      Text(label, style: Theme.of(context).textTheme.labelMedium),
      const SizedBox(height: 5),
      // Input
      TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      )
    ]);
  }
}
