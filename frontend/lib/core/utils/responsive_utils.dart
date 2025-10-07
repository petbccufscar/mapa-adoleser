// core/utils/responsive_utils.dart

import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveUtils {
  static EdgeInsetsGeometry pagePadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: horizontalPadding(context),
      vertical: verticalPadding(context),
    );
  }

  static double modalHorizontalPadding(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    if (responsive.isPhone) return ResponsivePaddings.modalHorizontalPhone;
    if (responsive.isTablet) return ResponsivePaddings.modalHorizontalTablet;
    if (responsive.isLargeTablet) {
      return ResponsivePaddings.modalHorizontalTableLarge;
    }
    if (responsive.isDesktop) return ResponsivePaddings.modalHorizontalDesktop;

    return ResponsivePaddings.modalHorizontalDesktopLarge;
  }

  static double modalVerticalPadding(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    if (responsive.isPhone) return ResponsivePaddings.modalVerticalPhone;
    if (responsive.isTablet) return ResponsivePaddings.modalVerticalTablet;
    if (responsive.isLargeTablet) {
      return ResponsivePaddings.modalVerticalTableLarge;
    }
    if (responsive.isDesktop) return ResponsivePaddings.modalVerticalDesktop;

    return ResponsivePaddings.modalVerticalDesktopLarge;
  }

  static double horizontalPadding(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    if (responsive.isPhone) return ResponsivePaddings.horizontalPhone;
    if (responsive.isTablet) return ResponsivePaddings.horizontalTablet;
    if (responsive.isLargeTablet) {
      return ResponsivePaddings.horizontalTableLarge;
    }
    if (responsive.isDesktop) return ResponsivePaddings.horizontalDesktop;

    return ResponsivePaddings.horizontalDesktopLarge;
  }

  static double verticalPadding(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    if (responsive.isPhone) return ResponsivePaddings.verticalPhone;
    if (responsive.isTablet) return ResponsivePaddings.verticalTablet;
    if (responsive.isLargeTablet) return ResponsivePaddings.verticalTableLarge;
    if (responsive.isDesktop) return ResponsivePaddings.verticalDesktop;

    return ResponsivePaddings.verticalDesktopLarge;
  }

  static bool shouldShowDrawer(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    if (responsive.isPhone || responsive.isTablet) return true;

    return false;
  }
}

extension CustomBreakpoints on ResponsiveBreakpointsData {
  bool get isLargeTablet => breakpoint.name == 'LARGE_TABLET';
  bool get isLargeDesktop => breakpoint.name == 'LARGE_DESKTOP';
}
