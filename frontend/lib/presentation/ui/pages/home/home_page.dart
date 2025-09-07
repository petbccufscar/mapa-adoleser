import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/carousel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/footer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

/// Página inicial da aplicação, exibida ao iniciar.
/// Integra componentes visuais e gerencia o layout da home.

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final isDark = themeProvider.themeMode == ThemeMode.dark;

    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: authProvider.isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: authProvider.isLoggedIn)
          : null,
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            Carousel(),
            ResponsivePageWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Text(
                        AppTexts.home.aboutTitle,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        AppTexts.home.aboutText,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Text(
                        AppTexts.home.mapTitle,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        AppTexts.home.mapText,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Footer()
          ],
        ),
      ),
    );
  }
}
