import 'package:flutter/material.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomDateField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool enabled;

  const CustomDateField({
    super.key,
    required this.label,
    this.hint,
    required this.controller,
    this.validator,
    this.textInputAction,
    this.enabled = true,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  late final MaskTextInputFormatter _maskFormatter;

  @override
  void initState() {
    _maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: widget.label,
      hint: widget.hint,
      controller: widget.controller,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      enabled: widget.enabled,
      inputFormatters: [_maskFormatter],
      keyboardType: TextInputType.datetime,
      // suffixIcon: Padding(
      //   padding: const EdgeInsets.only(right: 4.0), // ajuste a margem aqui
      //   child: IconButton(
      //     hoverColor: Colors.transparent,
      //     splashColor: Colors.transparent,
      //     highlightColor: Colors.transparent,
      //     icon: const Icon(Icons.calendar_month_rounded),
      //     onPressed: () {},
      //   ),
      // ),
    );
  }
}
