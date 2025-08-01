/// Contém constantes reutilizáveis na aplicação, como strings, tamanhos, margens, etc.
class ResponsivePaddings {
  static const double mobile = 16.0;
  static const double tablet = 64.0;
  static const double desktop = 192.0;
  static const double desktop_large = 320.0;
}

class AppDimensions {
  static const double appBarMainHeight = 65;
  static const double appBarSecondaryHeight = 40;

  static const double loggedInAppBarHeight =
      appBarMainHeight + appBarSecondaryHeight;

  static const double loggedOutAppBarHeight = appBarMainHeight;
}
