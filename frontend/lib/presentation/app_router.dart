import 'package:go_router/go_router.dart';

import 'pages/home/home_page.dart';
import 'pages/search/search_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/favorites/favorites_page.dart';
import 'pages/help/help_page.dart';
import 'pages/about/about_page.dart';
import 'pages/error/error_page.dart';

/// Gerencia as rotas de navegação da aplicação.
/// Define as páginas disponíveis e como navegar entre elas.

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  //errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/pesquisa', builder: (_, __) => const SearchPage()),
    GoRoute(path: '/perfil', builder: (_, __) => const ProfilePage()),
    GoRoute(path: '/favoritos', builder: (_, __) => const FavoritesPage()),
    GoRoute(path: '/ajuda', builder: (_, __) => const HelpPage()),
    GoRoute(path: '/sobre', builder: (_, __) => const AboutPage()),
  ],
);
