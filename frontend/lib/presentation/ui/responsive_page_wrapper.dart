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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.horizontalPadding(context),
              vertical: ResponsiveUtils.verticalPadding(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 30,
              children: [
                if (header != null) header!,
                body,
              ],
            ),
          ),
        ),
        if (footer != null) footer!,
      ],
    );
  }
}
