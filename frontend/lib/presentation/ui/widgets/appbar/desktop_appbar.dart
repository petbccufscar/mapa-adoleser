import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class DesktopAppBar extends StatelessWidget {
  const DesktopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    final authProvider = context.watch<AuthProvider>();

    final isLoggedIn = authProvider.isLoggedIn;
    final userName = authProvider.user?.name;

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: AppDimensions.loggedOutAppBarHeight,
          padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: ResponsiveUtils.horizontalPadding(context)),
          child: Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    context.go('/');
                  },
                  child: Image.asset(
                    'images/ADOLESER.png',
                    height: 40,
                    width: 160,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 5,
                    runSpacing: 8,
                    children: [
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
                          color: currentRoute == "/pesquisa"
                              ? AppColors.purple
                              : null,
                          colorOnHover: AppColors.purple),
                      const SizedBox(width: 15),
                      ActionText(
                          text: "Sobre",
                          action: () => {context.go("/sobre")},
                          bold: currentRoute == "/sobre",
                          boldOnHover: true,
                          color: currentRoute == "/sobre"
                              ? AppColors.purple
                              : null,
                          colorOnHover: AppColors.purple),
                      const SizedBox(width: 15),
                      ActionText(
                          text: "Fale Conosco",
                          action: () => {context.go("/contato")},
                          bold: currentRoute == "/contato",
                          boldOnHover: true,
                          color: currentRoute == "/contato"
                              ? AppColors.purple
                              : null,
                          colorOnHover: AppColors.purple),
                      if (!isLoggedIn && currentRoute != "/login") ...[
                        const SizedBox(width: 10),
                        const Text('•'),
                        const SizedBox(width: 12),
                        CustomButton(
                            text: 'Entrar',
                            onPressed: () => context.go('/login'))
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isLoggedIn)
          Container(
            height: AppDimensions.appBarSecondaryHeight,
            color: AppColors.purple,
            padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: ResponsiveUtils.horizontalPadding(context)),
            child: Row(
              children: [
                Text(
                  'Olá, $userName',
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
                        ? AppColors.textLightSmoke
                        : AppColors.textLight),
                const SizedBox(width: 15),
                ActionText(
                    text: "Perfil",
                    action: () => {context.go("/perfil")},
                    bold: currentRoute == "/perfil",
                    boldOnHover: true,
                    color: currentRoute == "/perfil"
                        ? AppColors.textLightSmoke
                        : AppColors.textLight),
                const SizedBox(width: 15),
                ActionText(
                  text: "Sair",
                  action: () async =>
                      {await context.read<AuthProvider>().logout()},
                  boldOnHover: true,
                  color: AppColors.textLight,
                  colorOnHover: AppColors.warning,
                ),
              ],
            ),
          )
      ],
    );
  }
}
