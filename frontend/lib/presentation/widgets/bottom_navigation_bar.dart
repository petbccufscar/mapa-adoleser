import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max_outlined),
          label: 'Início',
          tooltip: 'Página Inicial',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Pesquisar',
          tooltip: 'Pesquisar Conteúdo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
          tooltip: 'Itens Favoritos',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go('/pesquisa');
            break;
          case 2:
            context.go('/favoritos');
            break;
        }
      },
      currentIndex: 0, // Define o índice atual
      type: BottomNavigationBarType.fixed, // Tipo fixo para mais de 3 itens
    );
  }
}
