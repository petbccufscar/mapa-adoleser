import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // PARA TROCAR DE PÁGINA:
  // import 'package:go_router/go_router.dart';
  // context.go('/sobre'); // CORRETO com go_router

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tema Claro/Escuro'),
        actions: [
          Text(isDark ? "Escuro" : "Claro"),
          Switch(
            value: isDark,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Home!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
