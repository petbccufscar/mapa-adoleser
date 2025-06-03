import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  final String text;

  const CustomBackButton({super.key, this.text = "Voltar para a página inicial"});

  @override
  Widget build(BuildContext context) {
    // Verifica se está na página inicial
    final isHome = GoRouterState.of(context).uri.path == '/';

    // Se estiver na Home, retorna widget vazio (não mostra o botão)
    if (isHome) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.topLeft, // Alinha no canto superior esquerdo
      child: Padding(
        padding:
        const EdgeInsets.only(top: 6, left: 6), // Pequeno ajuste de posição
        child: Material(
          color: Colors.transparent, // Fundo transparente
          child: InkWell(
            borderRadius: BorderRadius.circular(
                24), // Borda arredondada para efeito visual
            onTap: () {
              // Lógica de navegação:
              if (context.canPop()) {
                context.pop(); // Volta para tela anterior (respeitando a pilha)
              } else {
                context.go('/'); // Se não houver histórico, vai para Home
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8), // Espaçamento interno
              child: Row(
                mainAxisSize:
                MainAxisSize.min, // Ocupa apenas espaço necessário
                children: [
                  // Ícone
                  const SizedBox(width: 3), // Espaço entre ícone e texto
                  Text(text, style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
