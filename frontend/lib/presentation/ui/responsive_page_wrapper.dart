import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';

class ResponsivePageWrapper extends StatelessWidget {
  final Widget child;

  const ResponsivePageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  AppDimensions.loggedInAppBarHeight,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.horizontalPadding(context),
                vertical: 25,
              ),
              child: child,
            )));
  }
}
