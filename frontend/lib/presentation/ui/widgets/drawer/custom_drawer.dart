import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final bool isLoggedIn;

  const CustomDrawer({
    super.key,
    required this.isLoggedIn,
  });

  void onNavigate(BuildContext context, String route) {
    Navigator.pop(context);
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    final userName = context.watch<AuthProvider>().user?.name;

    Widget route(String name, String route) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: currentRoute == route
            ? const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: AppColors.purple,
                    width: 4,
                  ),
                ),
              )
            : null,
        child: ActionText(
          text: name,
          action: () => {context.go(route)},
          bold: currentRoute == route,
          boldOnHover: true,
          color: currentRoute == route
              ? AppColors.purple
              : AppColors.textSecondary,
        ),
      );
    }

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          if (!isLoggedIn && currentRoute != "/login")
            Container(
              height: AppDimensions.endDrawerHeaderHeight,
              color: AppColors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  ActionText(
                    text: "Entre",
                    action: () {
                      context.go('/login');
                    },
                    underlined: true,
                    color: AppColors.textLight,
                  ),
                  const Text(
                    "ou",
                    style: TextStyle(color: AppColors.textLight),
                  ),
                  ActionText(
                    text: "crie sua conta",
                    action: () {
                      context.go('/cadastro');
                    },
                    underlined: true,
                    color: AppColors.textLight,
                  )
                ],
              ),
            ),
          if (isLoggedIn)
            Container(
              height: AppDimensions.loggedInEndDrawerHeaderHeight,
              color: AppColors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  CircleAvatar(
                    radius: 28, // tamanho do círculo
                    backgroundColor: AppColors.backgroundWhite,
                    child: Text(
                      userName![0]
                          .toUpperCase(), // pega a primeira letra em maiúscula
                      style: const TextStyle(
                        color: AppColors.purple,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(userName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.textLight))
                ],
              ),
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: AppColors.backgroundSmoke,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    "Rotas",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 5,
                    children: [
                      route('Início', '/'),
                      route('Pesquisa', '/pesquisa'),
                      if (isLoggedIn) ...[
                        route('Favoritos', '/favoritos'),
                        route('Perfil', '/perfil'),
                      ],
                      route('Sobre', '/sobre'),
                      route('Fale Conosco', '/contato'),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ActionText(
                            text: "Sair",
                            action: () async =>
                                {await context.read<AuthProvider>().logout()},
                            boldOnHover: true,
                            color: AppColors.textSecondary),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: AppColors.backgroundWhite,
            child: Text(
              "Copywrite © 2025 Mapa do Adolescente de São Carlos Inc. Powered By PET-BCC.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}
