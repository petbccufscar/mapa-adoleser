import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_card_atividade.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    final isLoggedIn = auth.isLoggedIn;

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: isLoggedIn)
          : null,
      body: const Center(
        child: Column(
          children: [
            CustomCardAtividade(
                imageUrl: 'assets/images/img1.jpg',
                title: 'Kartódromo',
                address: 'R. Dr. Donato dos Santos, 397 - Jardim Nova Santa Paula, São Carlos - SP, 13564-332',
                description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus cursus enim ut viverra...',
                rating: 3.5,
            ),

          ],
        )
      ),
    );
  }
}
