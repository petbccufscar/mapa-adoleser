import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer//custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: authProvider.isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: authProvider.isLoggedIn)
          : null,
      body: const Center(
        child: Text(
          'Perfil!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
