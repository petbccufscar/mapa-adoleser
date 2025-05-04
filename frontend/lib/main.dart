import 'package:flutter/material.dart';
import 'package:mapa_adoleser/theme/app_theme.dart';

import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

import 'routes/app_router.dart';

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
      routerConfig: router,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeMode,
    );
  }
}