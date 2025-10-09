import 'package:flutter/material.dart';

//Componente simples de botão com texto
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; //ação de envio
  final bool enabled; //botão habilitado ou desabilitado
  final IconData? icon;

  const CustomButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.icon,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled
          ? onPressed
          : null, //ação será feita apenas se o botão estiver habilitado
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          if (icon != null) Icon(icon),
          Text(text),
        ],
      ),
    );
  }
}
