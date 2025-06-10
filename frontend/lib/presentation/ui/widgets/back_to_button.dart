import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Widget personalizado que exibe um botão de voltar com texto e seta
class CustomBackButton extends StatefulWidget {
  final String text; // Texto exibido no botão
  final String path; // Caminho de navegação ao clicar

  const CustomBackButton({
    super.key,
    this.text = "Voltar para a página inicial",
    this.path = '/',
  });

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  bool _isHovering = false; // Controla se o mouse está sobre o botão

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Muda o cursor para "mãozinha"
      onEnter: (_) => setState(() => _isHovering = true), // Ativa sublinhado
      onExit: (_) => setState(() => _isHovering = false), // Remove sublinhado
      child: InkWell(
        onTap: () => context.go(widget.path), // Navega para a rota ao clicar
        borderRadius: BorderRadius.circular(
            24), // Borda arredondada para efeito do clique
        splashColor: Colors.transparent, // Remove cor de splash
        highlightColor: Colors.transparent, // Remove cor de destaque
        hoverColor: Colors.transparent, // Remove cor de hover
        child: Container(
          padding: const EdgeInsets.only(
              left: 2, right: 10, top: 2, bottom: 2), // Espaçamento interno
          child: Row(
            mainAxisSize: MainAxisSize.min, // Ocupa apenas o espaço necessário
            children: [
              const Icon(Icons.chevron_left), // Ícone de seta
              const SizedBox(width: 3), // Espaço entre ícone e texto
              Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      decoration: _isHovering ? TextDecoration.underline : null,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
