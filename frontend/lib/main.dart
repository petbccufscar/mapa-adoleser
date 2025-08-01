import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/theme/app_theme.dart';
import 'presentation/routes/app_router.dart';
import 'providers/theme_provider.dart';

/// Ponto de entrada da aplicação.
/// Inicializa o app, configura os temas e define a tela inicial.
/// Também pode configurar injeção de dependências, rotas e outras inicializações.

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    usePathUrlStrategy();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final router = createRouter(auth);

    return MaterialApp.router(
      title: 'Mapa Adoleser',
      routerConfig: router,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeMode,
      builder: (context, child) => ResponsiveBreakpoints.builder(breakpoints: [
        const Breakpoint(start: 0, end: 550, name: MOBILE),
        const Breakpoint(start: 551, end: 1101, name: TABLET),
        const Breakpoint(start: 1101, end: 1600, name: DESKTOP),
      ], child: child!),
      debugShowCheckedModeBanner: false,
    );
  }
}
