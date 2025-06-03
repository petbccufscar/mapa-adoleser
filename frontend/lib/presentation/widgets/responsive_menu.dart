import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

/// Widget de menu que se adapta ao tamanho da tela (mobile, tablet, desktop).
/// Utilizado para navegação em múltiplas resoluções.

class ResponsiveMenu extends StatelessWidget implements PreferredSizeWidget {
  const ResponsiveMenu({super.key});

  List<Widget>? getActions(BuildContext context, bool isDesktop) {
    if (isDesktop) {
      return [
        TextButton(
            onPressed: () => context.go('/pesquisa'),
            child: Text(
              'Pesquisa',
              style: Theme.of(context).textTheme.bodyLarge,
            )),
        TextButton(
            onPressed: () => context.go('/perfil'),
            child: Text(
              'Perfil',
              style: Theme.of(context).textTheme.bodyLarge,
            ))
      ];
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return AppBar(
        title: const Text('MAPA ADOLESER'),
        actions: getActions(context, isDesktop));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
