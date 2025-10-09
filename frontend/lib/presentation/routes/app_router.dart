import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/presentation/routes/guards.dart';
import 'package:mapa_adoleser/presentation/ui/pages/about/about_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/activity/activity_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/change_password/change_password_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/contact/contact_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/delete_account/delete_account_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/favorites/favorites_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/home/home_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/login/login_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/profile/profile_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/recovery_passoword/recovery_password_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/register/register_page.dart';
import 'package:mapa_adoleser/presentation/ui/pages/search/search_page.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:mapa_adoleser/providers/change_password_provider.dart';
import 'package:mapa_adoleser/providers/contact_provider.dart';
import 'package:mapa_adoleser/providers/delete_account_provider.dart';
import 'package:mapa_adoleser/providers/login_provider.dart';
import 'package:mapa_adoleser/providers/recovery_password_provider.dart';
import 'package:mapa_adoleser/providers/register_provider.dart';
import 'package:provider/provider.dart';

/// Gerencia as rotas de navegação da aplicação.
/// Define as páginas disponíveis e como navegar entre elas.
///
GoRouter createRouter(AuthProvider auth) {
  return GoRouter(
    // TODO: oq é isso?
    refreshListenable: auth,
    debugLogDiagnostics: true,
    initialLocation: '/atividade/1',
    //errorBuilder: (context, state) => const ErrorPage(),
    redirect: (context, state) => authGuard(auth, state),
    routes: [
      GoRoute(
          name: 'Home',
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage())),
      GoRoute(
          name: 'Pesquisa',
          path: '/pesquisa',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SearchPage())),
      GoRoute(
          name: 'Perfil',
          path: '/perfil',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfilePage())),
      GoRoute(
          name: 'Favoritos',
          path: '/favoritos',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FavoritesPage())),
      GoRoute(
        name: 'Contato',
        path: '/contato',
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (_) => ContactProvider(),
              child: const ContactPage(),
            ),
          );
        },
      ),
      GoRoute(
        name: 'Atividade',
        path: '/atividade/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;

          return NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (_) => ContactProvider(),
              child: ActivityPage(id: id),
            ),
          );
        },
      ),
      GoRoute(
          name: 'Sobre',
          path: '/sobre',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: AboutPage())),
      GoRoute(
        name: 'Login',
        path: '/login',
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (_) => LoginProvider(),
              child: const LoginPage(),
            ),
          );
        },
      ),
      GoRoute(
        name: 'Cadastro',
        path: '/cadastro',
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (_) => RegisterProvider(),
              child: const RegisterPage(),
            ),
          );
        },
      ),
      GoRoute(
        name: 'Recuperar Senha',
        path: '/recuperar-senha',
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (_) => RecoveryPasswordProvider(),
              child: const RecoveryPasswordPage(),
            ),
          );
        },
      ),
      GoRoute(
        name: 'Alterar Senha',
        path: '/alterar-senha',
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (_) => ChangePasswordProvider(),
              child: const ChangePasswordPage(),
            ),
          );
        },
      ),
      GoRoute(
        name: 'Excluir Conta',
        path: '/excluir-conta',
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (_) => DeleteAccountProvider(),
              child: const DeleteAccountPage(),
            ),
          );
        },
      ),
    ],
  );
}
