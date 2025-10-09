import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget label;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => onChanged(!value), // permite clicar no label
      child: Row(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 24,
              height: 24,
              padding: EdgeInsetsGeometry.all(2),
              decoration: BoxDecoration(
                color: value ? AppColors.purple : Colors.transparent,
                border: Border.all(color: AppColors.inputBorder, width: 1),
                borderRadius: BorderRadius.circular(6),
              )),
          label
        ],
      ),
    );
  }
}
