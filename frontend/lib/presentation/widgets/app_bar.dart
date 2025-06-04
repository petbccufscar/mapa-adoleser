import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// Widget de menu que se adapta ao tamanho da tela (mobile, tablet, desktop).
/// Utilizado para navegação em múltiplas resoluções.

/// Links do menu
class MenuLink extends StatefulWidget {
  final String text; // Texto exibido no botão
  final String path; // Caminho de navegação ao clicar

  const MenuLink({
    super.key,
    required this.text,
    required this.path,
  });

  @override
  State<MenuLink> createState() => _MenuLinkState();
}

class _MenuLinkState extends State<MenuLink> {
  bool _isHovering = false; // Controla se o mouse está sobre o botão

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Muda o cursor para "mãozinha"
      onEnter: (_) => setState(() => _isHovering = true), // Ativa sublinhado
      onExit: (_) => setState(() => _isHovering = false), // Remove sublinhado
      child: InkWell(
        onTap: () => context.go(widget.path), // Navega para a rota ao clicar
        hoverColor: Colors.transparent, // Remove cor de hover
        splashColor: Colors.transparent, // Remove cor de splash
        highlightColor: Colors.transparent, // Remove cor de destaque
        child: Container(
          padding: const EdgeInsets.all(2), // Espaçamento interno
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  decoration: _isHovering ? TextDecoration.underline : null,
                ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset('assets/images/ADOLESER.png'),
      titleSpacing: 32.0,
      elevation: 2.0,
      actions: const [
        MenuLink(text: "Início", path: '/'),
        MenuLink(text: "Pesquisar", path: '/pesquisa'),
        MenuLink(text: "Favoritos", path: '/favoritos')
      ],
      actionsPadding: const EdgeInsets.symmetric(horizontal: 32.0),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
