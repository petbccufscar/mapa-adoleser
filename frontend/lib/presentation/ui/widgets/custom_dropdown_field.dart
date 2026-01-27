import 'package:flutter/material.dart';

/// Widget customizado de campo dropdown, com estilo consistente com CustomTextField.

class CustomDropdownField<T> extends StatelessWidget {
  final String label; // Label acima do campo
  final String? hint; // Placeholder dentro do campo
  final T? value; // Valor selecionado atual
  final List<T> items; // Itens disponíveis no dropdown
  final void Function(T?) onChanged; // Callback ao selecionar item
  final String? Function(T?)? validator; // Validação do campo
  final String Function(T) getLabel;

  const CustomDropdownField(
      {super.key,
      required this.label,
      this.hint,
      required this.value,
      required this.items,
      required this.onChanged,
      this.validator,
      required this.getLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          DropdownButtonFormField<T>(
            icon: const Icon(Icons.keyboard_arrow_down),
            initialValue: value,
            items: items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  getLabel(item),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }).toList(),
            selectedItemBuilder: (context) {
              return items.map((item) {
                return Text(
                  getLabel(item),
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              }).toList();
            },
            onChanged: onChanged,
            validator: validator,
            hint: Text(
              hint!,
              style: Theme.of(context).inputDecorationTheme.hintStyle,
            ),
          ),
        ]);
  }
}
