import 'package:flutter/material.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/carousel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/footer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'home_sections.dart';

/// Página inicial da aplicação, exibida ao iniciar.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: isLoggedIn),
      endDrawer: CustomDrawer(isLoggedIn: isLoggedIn),
      body: SingleChildScrollView(
        child: Column(
          spacing: 60,
          children: const [
            Carousel(),
            ResponsivePageWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 64,
                children: [
                  AboutSection(),
                  NumbersSection(),
                  HowToUseSection(),
                  MapForYouSection(),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
