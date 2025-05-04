import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';
import '../pages/search_page.dart';
import '../pages/profile_page.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/pesquisa', builder: (_, __) => const SearchPage()),
    GoRoute(path: '/perfil', builder: (_, __) => const ProfilePage()),
  ],
);
