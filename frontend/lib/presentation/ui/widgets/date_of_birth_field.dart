import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Campo de input para selecionar a data de nascimento com verificação de idade mínima (12 anos).
class DateOfBirthField extends StatefulWidget {
  final void Function(DateTime?) onChanged;

  const DateOfBirthField({super.key, required this.onChanged});

  @override
  State<DateOfBirthField> createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(
        text: selectedDate == null
            ? ''
            : DateFormat('dd/MM/yyyy').format(selectedDate!),
      ),
      decoration: InputDecoration(
        labelText: 'Data de nascimento',
        hintText: 'dd/mm/aaaa',
        hintStyle: const TextStyle(
          color: Color(0xFFB0B0B0), // Cor do placeholder
        ),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Color(0xFF2E1B47), // Cor do título
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC9C9C9)), // Borda padrão
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF687082)), // Borda ao focar
        ),
        border: const OutlineInputBorder(), // Borda geral
      ),
      onTap: () async {
        final now = DateTime.now();

        // Define o intervalo de datas válidas: mínimo 100 anos atrás, máximo 12 anos atrás
        final minDate = DateTime(now.year - 100);
        final maxDate = DateTime(now.year - 12, now.month, now.day);

        // Abre o seletor de data
        final picked = await showDatePicker(
          context: context,
          initialDate: maxDate, // Data inicial sugerida
          firstDate: minDate, // Data mínima permitida
          lastDate: maxDate, // Data máxima permitida
        );

        if (picked != null) {
          // Atualiza o estado com a nova data selecionada
          setState(() => selectedDate = picked);
          widget.onChanged(picked); // Envia a data para o callback
        }
      },
      validator: (_) {
        // Validação do campo no formulário

        if (selectedDate == null) {
          return 'Selecione a data de nascimento';
        }

        // Calcula a idade aproximada em anos
        final age = DateTime.now().difference(selectedDate!).inDays ~/ 365;

        if (age < 12) {
          return 'É necessário ter pelo menos 12 anos';
        }

        return null;
      },
    );
  }
}
