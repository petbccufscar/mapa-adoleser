import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';

class ModalWrapper extends StatelessWidget {
  final Widget child;

  const ModalWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: Container(
        margin: EdgeInsetsGeometry.all(15),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsetsGeometry.symmetric(
          vertical: ResponsiveUtils.modalVerticalPadding(context),
          horizontal: ResponsiveUtils.modalHorizontalPadding(context),
        ),
        child: child,
      ),
    );
  }
}
