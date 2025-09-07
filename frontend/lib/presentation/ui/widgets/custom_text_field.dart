import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Widget customizado de campo de texto, possivelmente com estilos e validações personalizados.

class CustomTextField extends StatelessWidget {
  final String label; // Label do input
  final String? hint; // Placeholder o input
  final int maxLines;
  final TextInputType keyboardType; // Tipo de input
  final String? Function(String?)? validator; // Validação do campo
  final void Function(String)? onFieldSubmitted;
  final Widget? suffixIcon; // Ícone a esquerda
  final TextInputAction? textInputAction;
  final bool? enabled;
  final TextEditingController controller; // Controler para digitação
  final List<MaskTextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.maxLines = 1,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.enabled = true,
    this.onFieldSubmitted,
    this.textInputAction,
    this.inputFormatters,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          TextFormField(
            enabled: enabled,
            style: Theme.of(context).textTheme.bodyMedium,
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: validator,
            inputFormatters: inputFormatters,
            onFieldSubmitted: onFieldSubmitted,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: suffixIcon,
            ),
          )
        ]);
  }
}
