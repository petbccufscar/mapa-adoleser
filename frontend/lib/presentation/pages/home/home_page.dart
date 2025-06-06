import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

/// Página inicial da aplicação, exibida ao iniciar.
/// Integra componentes visuais e gerencia o layout da home.

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final isDark = themeProvider.themeMode == ThemeMode.dark;

    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home!',
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
