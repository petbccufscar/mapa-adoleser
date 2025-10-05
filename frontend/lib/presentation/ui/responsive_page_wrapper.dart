import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';

class ResponsivePageWrapper extends StatelessWidget {
  final Widget child;

  const ResponsivePageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.horizontalPadding(context),
        vertical: ResponsiveUtils.verticalPadding(context),
      ),
      child: child,
    );
  }
}
