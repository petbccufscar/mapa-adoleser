import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/presentation/routes/guards.dart';
import 'package:mapa_adoleser/presentation/ui/pages/about/about_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/contact/contact_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/favorites/favorites_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/home/home_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/login/login_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/message/message_result_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/profile/profile_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/register/forgot_password.dart';
import 'package:mapa_adoleser/presentation/ui/pages/register/register_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/search/search_page.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';

/// Gerencia as rotas de navegação da aplicação.
/// Define as páginas disponíveis e como navegar entre elas.
///
GoRouter createRouter(AuthProvider auth) {
  return GoRouter(
    refreshListenable: auth,
    debugLogDiagnostics: true,
    initialLocation: '/contato',
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
          //name: 'Contato',
          path: '/contato',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ContactPage()),
          routes: [
            GoRoute(
              path: '/envio',
              pageBuilder: (context, state) {
                final data = state.extra as Map<String, dynamic>;

                return NoTransitionPage(
                    child: MessageResultPage(
                  title: data['title'] as String,
                  message: data['message'] as String,
                ));
              },
            )
          ]),
      GoRoute(
          //name: 'Sobre',
          path: '/sobre',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: AboutPage())),
      GoRoute(
          //name: 'Login',
          path: '/login',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LoginPage())),
      GoRoute(
          //name: 'Cadastro',
          path: '/cadastro',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: RegisterPage())),
      GoRoute(
        //name: 'recuperar senha',
          path: '/recuperar-senha',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: ForgotPasswordPage()))
    ],
  );
}
