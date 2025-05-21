import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:go_router/go_router.dart';

class ResponsiveMenu extends StatelessWidget implements PreferredSizeWidget {
  final List<String> menuItems;

  const ResponsiveMenu({super.key, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return AppBar(
      title: const Text('MAPA ADOLESER'),
      actions: isDesktop
          ? menuItems.map((item) {
        return TextButton(
          onPressed: () {
            // context.go('/$item');
          },
          child: Text(
            item,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }).toList()
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
