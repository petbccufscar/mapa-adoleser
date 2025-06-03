import 'package:flutter/material.dart';
import 'package:mapa_adoleser/presentation/widgets/dropdown.dart';

import '../../widgets/responsive_menu.dart';

/// Página inicial da aplicação, exibida ao iniciar.
/// Integra componentes visuais e gerencia o layout da home.

class MyFormPage extends StatefulWidget {
  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  String? selectedOption;

  final List<DropdownMenuItem<String>> options = [
    const DropdownMenuItem(value: '1', child: Text('Opção 1')),
    const DropdownMenuItem(value: '2', child: Text('Opção 2')),
    const DropdownMenuItem(value: '3', child: Text('Opção 3')),
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: CustomDropdownField<String>(
        label: 'Categoria',
        hint: 'Selecione uma categoria',
        value: selectedOption,
        items: options,
        onChanged: (value) {
          setState(() {
            selectedOption = value;
          });
        },
        validator: (value) {
          if (value == null) return 'Por favor, selecione uma opção';
          return null;
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // PARA TROCAR DE PÁGINA:
  // import 'package:go_router/go_router.dart';
  // context.go('/sobre'); // CORRETO com go_router

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final isDark = themeProvider.themeMode == ThemeMode.dark;

    String? selectedOption;

    return Scaffold(
      appBar: const ResponsiveMenu(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Home!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            MyFormPage()
          ],
        ),
      ),
    );
  }
}
