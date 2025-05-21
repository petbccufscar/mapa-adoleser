import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/responsive_menu.dart';
import '../../widgets/text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // PARA TROCAR DE PÁGINA:
  // import 'package:go_router/go_router.dart';
  // context.go('/sobre'); // CORRETO com go_router

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final isDark = themeProvider.themeMode == ThemeMode.dark;

    final TextEditingController controller = TextEditingController();;

    final menuItems = ['sobre', 'pesquisa'];

    return Scaffold(
      appBar: ResponsiveMenu(menuItems: menuItems),
      body: Center(
        child: Column(
          children: [
            Text(
              'Home!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            CustomTextField(
              label: "Nome",
              hint: "Digite seu email",
              controller: controller,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Campo obrigatório";
                }
                if (!value.contains("@")) {
                  return "Email inválido";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
