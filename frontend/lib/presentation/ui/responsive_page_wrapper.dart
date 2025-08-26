import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';

class ResponsivePageWrapper extends StatelessWidget {
  final Widget body;
  final Widget? header;
  final Widget? footer;

  const ResponsivePageWrapper(
      {super.key, required this.body, this.header, this.footer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.horizontalPadding(context),
                vertical: ResponsiveUtils.verticalPadding(context),
              ),
              child: body,
            ),
          ),
        ),
        if (footer != null) footer!,
      ],
    );
  }
}
