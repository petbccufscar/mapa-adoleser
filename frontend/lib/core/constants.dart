/// Contém constantes reutilizáveis na aplicação, como strings, tamanhos, margens, etc.
class ResponsivePaddings {
  static const double horizontalPhone = 16.0;
  static const double horizontalTablet = 32.0;
  static const double horizontalTableLarge = 80.0;
  static const double horizontalDesktop = 192.0;
  static const double horizontalDesktopLarge = 320.0;

  static const double verticalPhone = 16.0;
  static const double verticalTablet = 16.0;
  static const double verticalTableLarge = 16.0;
  static const double verticalDesktop = 16.0;
  static const double verticalDesktopLarge = 16.0;
}

class AppDimensions {
  static const double appBarMainHeight = 65;
  static const double appBarSecondaryHeight = 40;

  static const double loggedOutAppBarHeight = appBarMainHeight;
  static const double loggedInAppBarHeight =
      appBarMainHeight + appBarSecondaryHeight;

  static const double endDrawerHeaderHeight = 65;
  static const double loggedInEndDrawerHeaderHeight = 105;

  static const double footerHeight = 100;
  static const double footerVerticalPadding = 15;
}

class AppTexts {
  AppTexts._(); // Construtor privado para evitar instância

  static const appName = 'Meu App';

  static const login = _LoginTexts();
  static const home = _HomeTexts();
}

class _LoginTexts {
  const _LoginTexts();

  final title = 'Entre com sua conta';
  final emailLabel = 'E-mail';
  final emailHint = 'Digite seu e-mail';
  final passwordLabel = 'Senha';
  final passwordHint = 'Digite sua senha';
  final forgotPassword = 'Esqueceu a senha?';
  final loginButton = 'Entrar';
  final unregistered = "Ainda não tem uma conta?";
  final createAccount = 'Crie uma!';
}

class _HomeTexts {
  const _HomeTexts();

  final aboutTitle = 'Mapa Adoleser';
  final aboutText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras egestas in sapien sit amet feugiat. Maecenas nec ullamcorper nisi. Nulla nunc  eros, porta nec semper ac, faucibus eu est. Aenean blandit ut mauris sit amet ullamcorper. Mauris non odio vel metus elementum lobortis.  Praesent nec eleifend metus. Donec vel lorem auctor eros sollicitudin  mattis. Nunc sed luctus ligula. In non leo nec sapien faucibus  condimentum. In et finibus ligula.  \n\nAenean sit amet urna finibus, aliquam nunc a, accumsan mi. Duis scelerisque, justo in sollicitudin ornare, dolor lacus viverra metus, sed consequat diam risus at leo. Suspendisse tincidunt eu ante nec fermentum. Ut lobortis eget risus consequat pulvinar. In mattis lorem laoreet lorem commodo accumsan eu ac arcu.';

  final mapTitle = 'Conheça m local que lhe fará bem';
  final mapText =
      'Use o mapa e os filtros abaixo para achar um bom lugar para você';
}
