import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MobileAppBar extends StatelessWidget {
  const MobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final isLoggedIn = authProvider.isLoggedIn;
    final userName = authProvider.user?.name;

    return Column(children: [
      Container(
          height: AppDimensions.loggedOutAppBarHeight,
          color: AppColors.backgroundSmoke,
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
                    width: 160,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 28,
                    color: AppColors.purple,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  }),
            ],
          )),
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
                )
              ],
            ))
    ]);
  }
}
