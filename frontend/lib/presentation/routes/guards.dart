// guards.dart
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';

String? authGuard(AuthProvider auth, GoRouterState state) {
  final loggedIn = auth.isLoggedIn;

  // Lista de rotas protegidas:
  final protectedRoutes = ['/perfil', '/favoritos'];

  // Verifica as rotas protegidas
  if (!loggedIn && protectedRoutes.contains(state.fullPath)) {
    return '/login';
  }

  //Se está logado não pode ir para '/login'
  if (loggedIn && state.fullPath == '/login') {
    return '/';
  }

  return null; // sem redirecionamento, deixa acessar
}
