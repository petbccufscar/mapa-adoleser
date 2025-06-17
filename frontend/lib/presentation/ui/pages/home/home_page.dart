import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/auth_provider.dart';
import '../../widgets/custom_app_bar.dart';

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
      appBar: const CustomAppBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Home!',
              style: TextStyle(fontSize: 24),
            ),
            // CustomButton(
            //   text: 'Sair',
            //   onPressed: () async {
            //     await context.read<AuthProvider>().logout();
            //   },
            // ),
            //Text('Bem-vindo, ${auth.user?.name ?? 'usuário'}!')
          ],
        ),
      ),
    );
  }
}