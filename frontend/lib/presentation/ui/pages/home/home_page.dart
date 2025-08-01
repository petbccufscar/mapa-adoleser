import 'package:flutter/material.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_app_bar.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

/// Página inicial da aplicação, exibida ao iniciar.
/// Integra componentes visuais e gerencia o layout da home.

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final isDark = themeProvider.themeMode == ThemeMode.dark;

    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: CustomAppBar(
        isLoggedIn: auth.isLoggedIn,
      ),
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
