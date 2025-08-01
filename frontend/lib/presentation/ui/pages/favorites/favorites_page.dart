import 'package:flutter/material.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_app_bar.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: auth.isLoggedIn),
      body: const Center(
        child: Text(
          'Favoritos!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
