import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/desktop_appbar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/mobile_appbar.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Widget de appbar que se adapta ao tamanho da tela (phone, tablet, desktop).
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
    final responsive = ResponsiveBreakpoints.of(context);

    return responsive.isPhone || responsive.isTablet
        ? const MobileAppBar()
        : const DesktopAppBar();
  }
}
