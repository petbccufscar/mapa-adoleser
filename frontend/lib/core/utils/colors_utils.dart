import 'package:flutter/material.dart';

class ColorsUtils {
  static Color categoryColor(String id) {
    switch (id) {
      case "1": // TODO: Nomear categoria
        return Colors.orange; // TODO: Colocar cores
      case "2":
        return Colors.green;
      case "3":
        return Colors.purple;
      case "4":
        return Colors.red;
      default:
        return Colors.pink;
    }
  }
}
