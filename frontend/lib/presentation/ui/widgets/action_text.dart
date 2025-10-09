import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';

class ActionText extends StatefulWidget {
  final String text;
  final VoidCallback? onTap; //ação de envio
  final bool underlined;
  final bool underlinedOnHover;
  final bool bold;
  final bool boldOnHover;
  final Color? color;
  final Color? colorOnHover;
  final MouseCursor mouse;
  final TextAlign alignment;

  const ActionText(
      {super.key,
      required this.text,
      required this.onTap,
      this.underlined = false,
      this.underlinedOnHover = false,
      this.bold = false,
      this.boldOnHover = true,
      this.color = AppColors.textSecondary,
      this.colorOnHover,
      this.mouse = SystemMouseCursors.click,
      this.alignment = TextAlign.start});

  @override
  State<ActionText> createState() => _ActionTextState();
}

class _ActionTextState extends State<ActionText> {
  bool _isHovering = false; // Controla se o mouse está sobre o botão

  Color get _effectiveColorOnHover => widget.colorOnHover ?? widget.color!;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.mouse,
      onEnter: (_) => setState(() => _isHovering = true), // Ativa sublinhado
      onExit: (_) => setState(() => _isHovering = false), // Remove sublinhado
      child: InkWell(
        onTap: widget.onTap,
        hoverColor: Colors.transparent, // Remove cor de hover
        splashColor: Colors.transparent, // Remove cor de splash
        highlightColor: Colors.transparent, // Remove cor de destaque
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              decorationColor:
                  _isHovering ? _effectiveColorOnHover : widget.color,
              decoration:
                  widget.underlined || widget.underlinedOnHover && _isHovering
                      ? TextDecoration.underline
                      : null,
              fontWeight: widget.bold || widget.boldOnHover && _isHovering
                  ? FontWeight.w600
                  : null,
              color: _isHovering ? _effectiveColorOnHover : widget.color),
          textAlign: widget.alignment,
        ),
      ),
    );
  }
}
