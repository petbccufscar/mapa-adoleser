import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button_avaliacao.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/avaliacao_dialog.dart';

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
      body: Center(
        child: AvaliacaoButton(
          text: 'Fazer uma avaliação',
          icon: Icons.add_circle_outline,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AvaliacaoDialog(),
            );
          },
        ),
        //child: Text(
        //'Busca!',
        //style: TextStyle(fontSize: 24),
        //),
      ),
    );
  }
}
