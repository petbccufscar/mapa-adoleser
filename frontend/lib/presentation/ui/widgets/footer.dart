import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart' as utils;
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: utils.ResponsiveUtils.horizontalPadding(context),
            vertical: AppDimensions.footerVerticalPadding,
          ),
          color: AppColors.backgroundSmoke,
          child: ResponsiveRowColumn(
            layout: responsive.smallerThan('LARGE_TABLET')
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            rowMainAxisAlignment: MainAxisAlignment.start,
            rowCrossAxisAlignment: CrossAxisAlignment.start,
            columnCrossAxisAlignment: CrossAxisAlignment.start,
            rowSpacing: 50,
            columnSpacing: 20,
            children: [
              ResponsiveRowColumnItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      "Redes",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(
                      spacing: 5,
                      children: [
                        IconButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(AppColors.purple),
                            ),
                            icon: const Icon(
                              Icons.abc,
                              size: 32,
                              color: AppColors.iconLight,
                            ),
                            onPressed: () {}),
                        IconButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(AppColors.purple),
                            ),
                            icon: const Icon(
                              Icons.abc,
                              size: 32,
                              color: AppColors.iconLight,
                            ),
                            onPressed: () {}),
                        IconButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(AppColors.purple),
                            ),
                            icon: const Icon(
                              Icons.abc,
                              size: 32,
                              color: AppColors.iconLight,
                            ),
                            onPressed: () {}),
                        IconButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(AppColors.purple),
                            ),
                            icon: const Icon(
                              Icons.abc,
                              size: 32,
                              color: AppColors.iconLight,
                            ),
                            onPressed: () {}),
                      ],
                    )
                  ],
                ),
              ),
              ResponsiveRowColumnItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      "Links importantes",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        ActionText(
                          text: "Segurança",
                          onTap: () {
                            context.go("/contato");
                          },
                          underlinedOnHover: true,
                          color: AppColors.buttonSecondary,
                        ),
                        ActionText(
                          text: "Acessibilidade",
                          onTap: () {
                            context.go("/pesquisa");
                          },
                          underlinedOnHover: true,
                          color: AppColors.buttonSecondary,
                        ),
                        ActionText(
                          text: "Cookies",
                          onTap: () {
                            context.go("/sobre");
                          },
                          underlinedOnHover: true,
                          color: AppColors.buttonSecondary,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: utils.ResponsiveUtils.horizontalPadding(context),
            vertical: AppDimensions.footerVerticalPadding,
          ),
          color: AppColors.purple,
          child: ResponsiveRowColumn(
            layout: responsive.smallerThan(TABLET)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            columnCrossAxisAlignment: CrossAxisAlignment.stretch,
            columnMainAxisAlignment: MainAxisAlignment.start,
            columnSpacing: 5,
            children: [
              ResponsiveRowColumnItem(
                child: Text(
                  "Copywrite © 2025 Mapa do Adolescente de São Carlos Inc.",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textLight),
                ),
              ),
              ResponsiveRowColumnItem(
                child: Text(
                  "Powered By PET-BCC.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textLight,
                      ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
