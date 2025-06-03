import 'package:flutter/material.dart';

import '../../widgets/responsive_menu.dart';

/// Página inicial da aplicação, exibida ao iniciar.
/// Integra componentes visuais e gerencia o layout da home.

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // PARA TROCAR DE PÁGINA:
  // import 'package:go_router/go_router.dart';
  // context.go('/sobre'); // CORRETO com go_router

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: const ResponsiveMenu(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Home!',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
