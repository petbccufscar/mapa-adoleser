import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_card_atividade.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    final isLoggedIn = auth.isLoggedIn;

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: isLoggedIn)
          : null,
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          return CustomCardAtividade(
              imageUrl: 'assets/images/img3.jpg',
              title: 'Mundo da Lua',
              address:
              'R. Dr. Donato dos Santos, 397 - Fenda do Biquíni - Oceano Pacífico',
              description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus cursus enim ut crux sac',
              rating: 4.6,
              ratingQtd: 24);
        },
      ),
    );
  }
}
