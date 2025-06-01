import 'package:go_router/go_router.dart';

import 'pages/home/home_page.dart';
import 'pages/search/search_page.dart';
import 'pages/profile/profile_page.dart';

/// Gerencia as rotas de navegação da aplicação.
/// Define as páginas disponíveis e como navegar entre elas.

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/pesquisa', builder: (_, __) => const SearchPage()),
    GoRoute(path: '/perfil', builder: (_, __) => const ProfilePage()),
  ],
);
