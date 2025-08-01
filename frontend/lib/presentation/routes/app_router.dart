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
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage())),
      GoRoute(
          //name: 'Pesquisa',
          path: '/pesquisa',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SearchPage())),
      GoRoute(
          //name: 'Perfil',
          path: '/perfil',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfilePage())),
      GoRoute(
          //name: 'Favoritos',
          path: '/favoritos',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FavoritesPage())),
      GoRoute(
          //name: 'Ajuda',
          path: '/ajuda',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HelpPage())),
      GoRoute(
          //name: 'Sobre',
          path: '/sobre',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: AboutPage())),
      GoRoute(
          //name: 'Login',
          path: '/login',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LoginPage()))
    ],
  );
}
