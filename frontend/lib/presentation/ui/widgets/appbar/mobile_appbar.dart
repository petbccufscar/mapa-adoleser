import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';

class MobileAppBar extends StatelessWidget {
  const MobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
          ))
    ]);
  }
}
