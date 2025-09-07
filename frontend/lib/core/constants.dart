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

  static const appName = 'Mapa Adoleser';

  static const login = _LoginTexts();
  static const home = _HomeTexts();
  static const register = _RegisterTexts();
  static const help = _HelpTexts();
  static const forgotPassword = _ForgotPasswordTexts();
}

class _HelpTexts {
  const _HelpTexts();

  final title = 'Envie sua mensagem';
  final emailLabel = 'E-mail';
  final emailHint = 'Digite seu e-mail';
  final nameLabel = 'Nome';
  final nameHint = 'Digite seu nome';
  final subjectLabel = 'Assunto';
  final subjectHint = 'Selecione o assunto do contato';
  final messageLabel = 'Mensagem';
  final messageHint = 'Digite aqui sua mensagem';
  final helpButton = 'Enviar';
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

class _ForgotPasswordTexts{
  const _ForgotPasswordTexts();

  final title = 'Recuperar sua senha';
  final emailLabel = 'Digite seu e-mail para receber um código de confirmação';
  final emailHint = 'Digite seu e-mail';
  final emailSubmit = 'Enviar';
  final codeLabel = 'Digite o código de 6 dígitos recebido';
  final codeValidate = 'Validar';
  final codeResend = 'Reenviar ';
  final passwordLabel = "Nova senha";
  final newPassword = "Digite sua nova senha";
  final passwordAgainLabel = "Confirme a nova senha";
  final newPasswordAgain = "Digite novamente sua nova senha";
  final successMessage = "Sua senha foi alterada com sucesso!";
  final returnLogin = "Retornar para o login";
}

class _RegisterTexts {
  const _RegisterTexts();

  final successMessage = 'Conta criada com com sucesso!';
  final title = 'Crie sua conta';
  final nameLabel = 'Nome completo';
  final nameHint = 'Digite seu nome completo';
  final emailLabel = 'E-mail';
  final emailHint = 'Digite seu e-mail';
  final birthDateLabel = 'Data de Nascimento';
  final birthDateHint = 'dd/mm/aaaa';
  final passwordLabel = 'Senha';
  final passwordHint = 'Crie sua senha';
  final confirmPasswordLabel = 'Confirme sua senha';
  final confirmPasswordHint = 'Confirme sua senha';
  final forgotPassword = 'Esqueceu a senha?';
  final registerButton = 'Criar minha conta';
  final registered = 'Ja tem uma conta?';
  final loginAccount = 'Faça login!';
  final checkBoxText = 'Ao marcar esta caixa, você concorda com nossos ';
  final checkBoxTextTerms = 'Termos de Uso e Políticas de Privacidade';
}

class _HomeTexts {
  const _HomeTexts();

  final aboutTitle = 'Mapa Adoleser';
  final aboutText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras egestas in sapien sit amet feugiat. Maecenas nec ullamcorper nisi. Nulla nunc  eros, porta nec semper ac, faucibus eu est. Aenean blandit ut mauris sit amet ullamcorper. Mauris non odio vel metus elementum lobortis.  Praesent nec eleifend metus. Donec vel lorem auctor eros sollicitudin  mattis. Nunc sed luctus ligula. In non leo nec sapien faucibus  condimentum. In et finibus ligula.  \n\nAenean sit amet urna finibus, aliquam nunc a, accumsan mi. Duis scelerisque, justo in sollicitudin ornare, dolor lacus viverra metus, sed consequat diam risus at leo. Suspendisse tincidunt eu ante nec fermentum. Ut lobortis eget risus consequat pulvinar. In mattis lorem laoreet lorem commodo accumsan eu ac arcu.';

  final mapTitle = 'Conheça um local que lhe fará bem';
  final mapText =
      'Use o mapa e os filtros abaixo para achar um bom lugar para você';
}
