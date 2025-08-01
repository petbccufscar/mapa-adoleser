import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

/// Widget de menu que se adapta ao tamanho da tela (mobile, tablet, desktop).
/// Utilizado para navegação em múltiplas resoluções.

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLoggedIn;

  const CustomAppBar({super.key, required this.isLoggedIn});

  @override
  Size get preferredSize => Size.fromHeight(
        isLoggedIn
            ? AppDimensions.loggedInAppBarHeight
            : AppDimensions.loggedOutAppBarHeight,
      );

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    return Column(
      children: [
        Container(
            height: AppDimensions.loggedOutAppBarHeight,
            color: AppColors.backgroundSmoke,
            padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: ResponsiveUtils.horizontalPadding(context)),
            child: Row(
              children: [
                Image.asset('images/ADOLESER.png', width: 160),
                const Spacer(),
                ActionText(
                    text: "Início",
                    action: () => {context.go("/")},
                    bold: currentRoute == "/",
                    boldOnHover: true,
                    color: currentRoute == "/" ? AppColors.purple : null,
                    colorOnHover: AppColors.purple),
                const SizedBox(width: 15),
                ActionText(
                    text: "Pesquisar",
                    action: () => {context.go("/pesquisa")},
                    bold: currentRoute == "/pesquisa",
                    boldOnHover: true,
                    color:
                        currentRoute == "/pesquisa" ? AppColors.purple : null,
                    colorOnHover: AppColors.purple),
                const SizedBox(width: 15),
                ActionText(
                    text: "Sobre",
                    action: () => {context.go("/sobre")},
                    bold: currentRoute == "/sobre",
                    boldOnHover: true,
                    color: currentRoute == "/sobre" ? AppColors.purple : null,
                    colorOnHover: AppColors.purple),
                const SizedBox(width: 15),
                ActionText(
                    text: "Ajuda",
                    action: () => {context.go("/ajuda")},
                    bold: currentRoute == "/ajuda",
                    boldOnHover: true,
                    color: currentRoute == "/ajuda" ? AppColors.purple : null,
                    colorOnHover: AppColors.purple),
                if (!auth.isLoggedIn && currentRoute != "/login")
                  const SizedBox(width: 10),
                if (!auth.isLoggedIn && currentRoute != "/login")
                  const Text('•'),
                if (!auth.isLoggedIn && currentRoute != "/login")
                  const SizedBox(width: 12),
                if (!auth.isLoggedIn && currentRoute != "/login")
                  CustomButton(
                      text: 'Entrar', onPressed: () => context.go('/login'))
              ],
            )),
        if (auth.isLoggedIn)
          Container(
              height: AppDimensions.appBarSecondaryHeight,
              color: AppColors.pink,
              padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: ResponsiveUtils.horizontalPadding(context)),
              child: Row(
                children: [
                  Text(
                    'Olá, ${auth.user!.name}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.textLight),
                  ),
                  const Spacer(),
                  ActionText(
                      text: "Favoritos",
                      action: () => {context.go("/favoritos")},
                      bold: currentRoute == "/favoritos",
                      boldOnHover: true,
                      color: currentRoute == "/favoritos"
                          ? AppColors.textSecondary
                          : AppColors.textLight),
                  const SizedBox(width: 15),
                  ActionText(
                      text: "Perfil",
                      action: () => {context.go("/perfil")},
                      bold: currentRoute == "/perfil",
                      boldOnHover: true,
                      color: currentRoute == "/perfil"
                          ? AppColors.textSecondary
                          : AppColors.textLight),
                  const SizedBox(width: 15),
                  ActionText(
                    text: "Sair",
                    action: () async =>
                        {await context.read<AuthProvider>().logout()},
                    boldOnHover: true,
                    color: AppColors.textLight,
                    colorOnHover: AppColors.textPrimary,
                  ),
                ],
              ))
      ],
    );
  }
}
