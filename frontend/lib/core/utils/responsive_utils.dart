// core/utils/responsive_utils.dart

import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveUtils {
  static double horizontalPadding(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    if (responsive.isMobile) return ResponsivePaddings.mobile;
    if (responsive.isTablet) return ResponsivePaddings.tablet;
    if (responsive.isDesktop) return ResponsivePaddings.desktop;
    return ResponsivePaddings.desktop_large;
  }
}
