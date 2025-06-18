import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

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
    bool _isCurrentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString() ==
            widget.path;

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
                fontWeight: _isCurrentRoute ? FontWeight.w600 : null,
                color: _isCurrentRoute ? AppColors.purple : null),
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
    final auth = context.watch<AuthProvider>();

    return PreferredSize(
      preferredSize: Size.infinite,
      child: Column(
        children: [
          Container(
              color: AppColors.backgroundWhite,
              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: MediaQuery.of(context).size.width * 0.10),
              child: Row(
                children: [
                  Image.asset('images/ADOLESER.png', width: 160),
                  const Spacer(),
                  const MenuLink(text: "Início", path: '/'),
                  const SizedBox(width: 10),
                  const MenuLink(text: "Pesquisar", path: '/pesquisa'),
                  const SizedBox(width: 10),
                  const MenuLink(text: "Sobre", path: '/sobre'),
                  const SizedBox(width: 10),
                  const MenuLink(text: "Ajuda", path: '/ajuda'),
                  if (!auth.isLoggedIn) const SizedBox(width: 10),
                  if (!auth.isLoggedIn) const Text('•'),
                  if (!auth.isLoggedIn) const SizedBox(width: 12),
                  if (!auth.isLoggedIn)
                    CustomButton(
                        text: 'Entrar', onPressed: () => context.go('/login'))
                ],
              )),
          if (auth.isLoggedIn)
            Container(
                color: AppColors.purple,
                padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: MediaQuery.of(context).size.width * 0.10),
                child: Row(
                  children: [
                    Text(
                      'Olá, ${auth.user!.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.textLight),
                    ),
                    const Spacer(),
                    const MenuLink(text: "Favoritos", path: '/favoritos'),
                    const SizedBox(width: 10),
                    const MenuLink(text: "Perfil", path: '/perfil'),
                    CustomButton(
                      text: 'Sair',
                      onPressed: () async {
                        await context.read<AuthProvider>().logout();
                      },
                    )
                  ],
                ))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 70);
}
