import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/presentation/routes/guards.dart';
import 'package:mapa_adoleser/presentation/ui/pages/about/about_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/favorites/favorites_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/help/help_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/home/home_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/login/login_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/profile/profile_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/search/search_page.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';

/// Gerencia as rotas de navegação da aplicação.
/// Define as páginas disponíveis e como navegar entre elas.
///
GoRouter createRouter(AuthProvider auth) {
  return GoRouter(
    refreshListenable: auth,
    debugLogDiagnostics: true,
    initialLocation: '/',
    //errorBuilder: (context, state) => const ErrorPage(),
    redirect: (context, state) => authGuard(auth, state),
    routes: [
      GoRoute(
          //name: 'Home',
          path: '/',
          builder: (context, state) => const HomePage()),
      GoRoute(
          //name: 'Pesquisa',
          path: '/pesquisa',
          builder: (context, state) => const SearchPage()),
      GoRoute(
          //name: 'Perfil',
          path: '/perfil',
          builder: (context, state) => const ProfilePage()),
      GoRoute(
          //name: 'Favoritos',
          path: '/favoritos',
          builder: (context, state) => const FavoritesPage()),
      GoRoute(
          //name: 'Ajuda',
          path: '/ajuda',
          builder: (context, state) => const HelpPage()),
      GoRoute(
          //name: 'Sobre',
          path: '/sobre',
          builder: (context, state) => const AboutPage()),
      GoRoute(
          //name: 'Login',
          path: '/login',
          builder: (context, state) => const LoginPage())
    ],
  );
}
