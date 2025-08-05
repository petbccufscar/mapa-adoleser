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
                      context.go('/ajuda');
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: currentRoute == "/"
                            ? const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.purple, // Cor da borda
                                    width: 4, // Largura da borda
                                  ),
                                ),
                              )
                            : null,
                        child: ActionText(
                            text: "Início",
                            action: () => {context.go("/")},
                            bold: currentRoute == "/",
                            boldOnHover: true,
                            color: currentRoute == "/"
                                ? AppColors.purple
                                : AppColors.textSecondary),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: currentRoute == "/pesquisa"
                            ? const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.purple, // Cor da borda
                                    width: 4, // Largura da borda
                                  ),
                                ),
                              )
                            : null,
                        child: ActionText(
                            text: "Pesquisa",
                            action: () => {context.go("/pesquisa")},
                            bold: currentRoute == "/pesquisa",
                            boldOnHover: true,
                            color: currentRoute == "/pesquisa"
                                ? AppColors.purple
                                : AppColors.textSecondary),
                      ),
                      if (isLoggedIn) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: currentRoute == "/favoritos"
                              ? const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: AppColors.purple, // Cor da borda
                                      width: 4, // Largura da borda
                                    ),
                                  ),
                                )
                              : null,
                          child: ActionText(
                              text: "Favoritos",
                              action: () => {context.go("/favoritos")},
                              bold: currentRoute == "/favoritos",
                              boldOnHover: true,
                              color: currentRoute == "/favoritos"
                                  ? AppColors.purple
                                  : AppColors.textSecondary),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: currentRoute == "/perfil"
                              ? const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: AppColors.purple, // Cor da borda
                                      width: 4, // Largura da borda
                                    ),
                                  ),
                                )
                              : null,
                          child: ActionText(
                              text: "Perfil",
                              action: () => {context.go("/perfil")},
                              bold: currentRoute == "/perfil",
                              boldOnHover: true,
                              color: currentRoute == "/perfil"
                                  ? AppColors.purple
                                  : AppColors.textSecondary),
                        ),
                      ],
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: currentRoute == "/sobre"
                            ? const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.purple, // Cor da borda
                                    width: 4, // Largura da borda
                                  ),
                                ),
                              )
                            : null,
                        child: ActionText(
                            text: "Sobre",
                            action: () => {context.go("/sobre")},
                            bold: currentRoute == "/sobre",
                            boldOnHover: true,
                            color: currentRoute == "/sobre"
                                ? AppColors.purple
                                : AppColors.textSecondary),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: currentRoute == "/ajuda"
                            ? const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.purple, // Cor da borda
                                    width: 4, // Largura da borda
                                  ),
                                ),
                              )
                            : null,
                        child: ActionText(
                            text: "Ajuda",
                            action: () => {context.go("/ajuda")},
                            bold: currentRoute == "/ajuda",
                            boldOnHover: true,
                            color: currentRoute == "/ajuda"
                                ? AppColors.purple
                                : AppColors.textSecondary),
                      ),
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
