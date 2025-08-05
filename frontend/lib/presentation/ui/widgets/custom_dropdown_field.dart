import 'package:flutter/material.dart';

/// Widget customizado de campo dropdown, com estilo consistente com CustomTextField.

class CustomDropdownField<T> extends StatelessWidget {
  final String label; // Label acima do campo
  final String? hint; // Placeholder dentro do campo
  final T? value; // Valor selecionado atual
  final List<DropdownMenuItem<T>> items; // Itens disponíveis no dropdown
  final void Function(T?) onChanged; // Callback ao selecionar item
  final String? Function(T?)? validator; // Validação do campo

  const CustomDropdownField(
      {super.key,
      required this.label,
      this.hint,
      required this.value,
      required this.items,
      required this.onChanged,
      this.validator});

  // String? selectedOption;
  // final List<String> options = const ['Academia', 'Parque', 'Praça'];

  // CustomDropdownField(
  //   hint: "Categoria",
  //   label: 'Selecione uma categoria',
  //   value: selectedOption,
  //   items: options
  //       .map((op) => DropdownMenuItem(
  //             value: op,
  //             child: Text(op),
  //           ))
  //       .toList(),
  //   onChanged: (value) => {},
  //   validator: (value) {
  //     if (value == null || value.isEmpty) {
  //       return 'Selecione uma categoria';
  //     }
  //
  //     return null;
  //   },
  // ),

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        label,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      const SizedBox(height: 5),
      DropdownButtonFormField<T>(
          icon: const Icon(Icons.keyboard_arrow_down),
          value: value,
          items: items,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ))
    ]);
  }
}
