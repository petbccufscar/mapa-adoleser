import 'package:flutter/material.dart';

import 'package:mapa_adoleser/presentation/widgets/bottom_navigation_bar.dart';
import '../../widgets/app_bar.dart';

/// Página inicial da aplicação, exibida ao iniciar.
/// Integra componentes visuais e gerencia o layout da home.

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final isDark = themeProvider.themeMode == ThemeMode.dark;

    bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      appBar: isDesktop ? const CustomAppBar() : null,
      bottomNavigationBar: isDesktop ? null : const CustomBottomNavigationBar(),
      body: Center(
        child: Text(
          'Home!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
