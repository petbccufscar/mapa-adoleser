import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final String? label;
  final String? hint;
  final bool showPasswordStrength;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  const CustomPasswordField({
    super.key,
    this.label,
    this.hint,
    required this.controller,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.showPasswordStrength = false,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;
  String _passwordStrength = '';

  // Função para avaliar força da senha
  void _updatePasswordStrength(String password) {
    String strength;
    if (password.isEmpty) {
      strength = '';
    } else if (password.length < 6) {
      strength = 'Fraca';
    } else if (password.length < 10 ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      strength = 'Média';
    } else {
      strength = 'Forte';
    }

    setState(() {
      _passwordStrength = strength;
    });
  }

  Color _getStrengthColor() {
    switch (_passwordStrength) {
      case 'Fraca':
        return Colors.green;
      case 'Média':
        return Colors.orange;
      case 'Forte':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label != null)
          Text(widget.label!, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 5),

        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          validator: widget.validator,
          onChanged: _updatePasswordStrength,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            suffixIcon: Padding(
              padding:
                  const EdgeInsets.only(right: 4.0), // ajuste a margem aqui
              child: IconButton(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
        ),

        if (widget.showPasswordStrength && _passwordStrength.isNotEmpty) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                'Força da senha: ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                _passwordStrength,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getStrengthColor(),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
