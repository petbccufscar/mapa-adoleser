import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

import 'presentation/app_router.dart';
import 'core/theme/app_theme.dart';

/// Ponto de entrada da aplicação.
/// Inicializa o app, configura os temas e define a tela inicial.
/// Também pode configurar injeção de dependências, rotas e outras inicializações.

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      title: 'Mapa Adoleser',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeMode,
    );
  }
}