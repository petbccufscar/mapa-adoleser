import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Widget reutilizável que exibe um link com texto clicável
/// e redireciona para uma rota usando o GoRouter.
class CustomLink extends StatefulWidget {
  final String text; // Texto do link
  final String path; // Rota para redirecionar ao clicar

  const CustomLink({
    super.key,
    required this.text,
    required this.path,
  });

  @override
  State<CustomLink> createState() => _CustomLinkState();
}

class _CustomLinkState extends State<CustomLink> {
  bool _isHovering = false; // Indica se o mouse está sobre o link

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Muda o cursor para "mãozinha"
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: () => context.go(widget.path), // Navega para a rota definida
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 12, // Tamanho conforme o Figma
            color: const Color(0xFF3F1153), // Roxo escuro
            decoration: TextDecoration.underline, // Sublinhado sempre
            letterSpacing: 0.0, // Sem espaçamento extra
            fontWeight: FontWeight.normal, // Pode mudar se quiser negrito
          ),
        ),
      ),
    );
  }
}
// Exemplo de como usar:
        // const CustomLink(
          //  text: "Entre ou crie sua conta",
          //  path: "/login", // ou "/cadastro"
