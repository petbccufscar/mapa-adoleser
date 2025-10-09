/// Contém constantes reutilizáveis na aplicação, como strings, tamanhos, margens, etc.
class ResponsivePaddings {
  static const double modalHorizontalPhone = 20.0;
  static const double modalHorizontalTablet = 30.0;
  static const double modalHorizontalTableLarge = 30.0;
  static const double modalHorizontalDesktop = 30.0;
  static const double modalHorizontalDesktopLarge = 30.0;

  static const double modalVerticalPhone = 35.0;
  static const double modalVerticalTablet = 35.0;
  static const double modalVerticalTableLarge = 35.0;
  static const double modalVerticalDesktop = 35.0;
  static const double modalVerticalDesktopLarge = 35.0;

  static const double horizontalPhone = 16.0;
  static const double horizontalTablet = 32.0;
  static const double horizontalTableLarge = 64.0;
  static const double horizontalDesktop = 192.0;
  static const double horizontalDesktopLarge = 320.0;

  static const double verticalPhone = 16.0;
  static const double verticalTablet = 32.0;
  static const double verticalTableLarge = 48.0;
  static const double verticalDesktop = 64.0;
  static const double verticalDesktopLarge = 64.0;
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
  static const contact = _ContactTexts();
  static const recoveryPassword = _RecoveryPasswordTexts();
  static const changePassword = _ChangePasswordTexts();
  static const about = _AboutTexts();
  static const deleteAccount = _DeleteAccountTexts();
  static const profile = _ProfileTexts();
}

class _ProfileTexts {
  const _ProfileTexts();

  // Títulos e descrições gerais
  final title = 'Meu Perfil';
  final subtitle =
      'Gerencie suas informações pessoais, segurança e preferências da conta';

  // Seção: Informações pessoais
  final personalInfoTitle = 'Informações Pessoais';
  final emailLabel = 'E-mail';
  final usernameLabel = 'Usuário';
  final usernameHint = 'Digite seu nome de usuário';
  final nameLabel = 'Nome completo';
  final nameHint = 'Digite seu nome completo';
  final birthDateLabel = 'Data de Nascimento';
  final birthDateHint = 'dd/mm/aaaa';

  // Botões de edição
  final editButtonText = 'Editar';
  final cancelButtonText = 'Cancelar';
  final saveButtonText = 'Salvar';

  // Mensagens de feedback
  final saveErrorMessage = 'Falha ao salvar suas informações';
  final saveSuccessMessage = 'Informações atualizadas com sucesso';

  // Seção: Segurança
  final securityTitle = 'Segurança';
  final changePasswordLabel = 'Alterar senha';
  final privacyPolicyLabel = 'Política de Privacidade';
  final termsOfUseLabel = 'Termos de Uso';

  // Seção: Zona de perigo
  final dangerZoneTitle = 'Zona de Perigo';
  final deleteAccountLabel = 'Excluir minha conta';
}

class _DeleteAccountTexts {
  const _DeleteAccountTexts();

  // Título e instruções iniciais
  final title = 'Excluir conta';
  final confirmCredentialsMessage =
      'Confirme seu e-mail e senha para receber um código de confirmação.';

  // Campos de autenticação
  final emailLabel = 'E-mail';
  final emailHint = 'Digite seu e-mail';
  final passwordLabel = 'Senha';
  final passwordHint = 'Digite sua senha';

  // Ações e botões
  final sendCodeButtonText = 'Enviar';
  final cancelButtonText = 'Cancelar';
  final confirmButtonText = 'Deletar';
  final returnHomeButtonText = 'Voltar para a página inicial';

  // Mensagens de feedback
  final codeSentSuccessMessage = 'Código enviado com sucesso!';
  final deleteSuccessMessage = 'Sua conta foi excluída com sucesso!';

  // Instruções sobre o código de confirmação
  final codeInstructionsMessage =
      'Um código de confirmação foi enviado para o seu e-mail. Insira o código abaixo para continuar.';
  final codeLabel = 'Código de 6 dígitos';

  // Confirmação de exclusão
  final deleteConfirmationMessage =
      'Deseja realmente excluir sua conta? Seus dados serão permanentemente apagados e não poderão ser recuperados.';
}

class _ContactTexts {
  const _ContactTexts();

  // Título
  final title = 'Envie sua mensagem';

  // Campos do formulário
  final emailLabel = 'E-mail';
  final emailHint = 'Digite seu e-mail';

  final nameLabel = 'Nome';
  final nameHint = 'Digite seu nome';

  final subjectLabel = 'Assunto';
  final subjectHint = 'Selecione o assunto do contato';

  final messageLabel = 'Mensagem';
  final messageHint = 'Digite sua mensagem aqui';

  // Botão
  final sendButtonText = 'Enviar';
}

class _LoginTexts {
  const _LoginTexts();

  // Mensagens de boas-vindas
  final welcomeMessage = 'Bem-vindo de volta!';
  final welcomeSubtitle =
      'Faça login com suas credenciais para acessar sua conta.';

  // Título
  final title = 'Entrar na conta';

  // Campos do formulário
  final emailLabel = 'E-mail';
  final emailHint = 'Digite seu e-mail';

  final passwordLabel = 'Senha';
  final passwordHint = 'Digite sua senha';

  // Opções adicionais
  final forgotPasswordText = 'Esqueceu sua senha?';
  final rememberMeLabel = 'Lembrar de mim';

  // Botões e navegação
  final loginButtonText = 'Entrar';
  final noAccountMessage = 'Ainda não tem uma conta?';
  final createAccountButtonText = 'Criar conta';
}

class _RecoveryPasswordTexts {
  const _RecoveryPasswordTexts();

  // Título e instruções iniciais
  final title = 'Recuperar senha';
  final emailInstructions =
      'Digite seu e-mail para receber um código de confirmação.';

  // Campo de e-mail
  final emailLabel = 'E-mail';
  final emailHint = 'Digite seu e-mail';

  // Botões iniciais
  final sendCodeButtonText = 'Enviar';
  final cancelButtonText = 'Cancelar';

  // Código de verificação
  final codeLabel = 'Código de 6 dígitos';
  final codeInstructions =
      'Insira o código que enviamos para o seu e-mail para continuar a recuperação da senha.';
  final validateCodeButtonText = 'Validar';
  final resendCodeButtonText = 'Reenviar código';
  final codeResentSuccessMessage = 'Código reenviado com sucesso!';

  // Nova senha
  final newPasswordInstructions =
      'Crie uma nova senha para sua conta. Ela deve conter no mínimo 8 caracteres, incluindo letras maiúsculas, minúsculas, números e caracteres especiais.';
  final newPasswordLabel = 'Nova senha';
  final newPasswordHint = 'Digite sua nova senha';
  final confirmNewPasswordLabel = 'Confirmar nova senha';
  final confirmNewPasswordHint = 'Repita sua nova senha';

  // Mensagens de sucesso
  final successMessage =
      'Senha alterada com sucesso! Faça login novamente com sua nova senha.';
  final backToLoginButtonText = 'Voltar para o login';
}

class _ChangePasswordTexts {
  const _ChangePasswordTexts();

  // Título e instruções
  final title = 'Alterar senha';
  final currentPasswordInstructions =
      'Para alterar sua senha, primeiro confirme sua senha atual.';
  final newPasswordInstructions =
      'Agora, crie uma nova senha para sua conta. Ela deve conter no mínimo 8 caracteres, incluindo letras maiúsculas, minúsculas, números e caracteres especiais.';

  // Campos do formulário
  final currentPasswordLabel = 'Senha atual';
  final currentPasswordHint = 'Digite sua senha atual';

  final newPasswordLabel = 'Nova senha';
  final newPasswordHint = 'Digite sua nova senha';

  final confirmNewPasswordLabel = 'Confirmar nova senha';
  final confirmNewPasswordHint = 'Repita sua nova senha';

  // Botões
  final cancelButtonText = 'Cancelar';
  final changePasswordButtonText = 'Alterar senha';
  final backToHomeButtonText = 'Voltar para a página inicial';

  // Mensagens de feedback
  final successMessage = 'Senha alterada com sucesso!';
  final successDescription =
      'Sua senha foi atualizada com sucesso. Use a nova senha na próxima vez que fizer login.';
}

class _RegisterTexts {
  const _RegisterTexts();

  // Mensagens de boas-vindas
  final welcomeMessage = 'Faça seu cadastro!';
  final welcomeSubtitle = 'Preencha os campos abaixo para criar sua conta.';

  // Título
  final title = 'Criar conta';

  // Mensagens de feedback
  final successMessage = 'Conta criada com sucesso!';

  // Campos do formulário
  final nameLabel = 'Nome completo';
  final nameHint = 'Digite seu nome completo';

  final emailLabel = 'E-mail';
  final emailHint = 'Digite seu e-mail';

  final usernameLabel = 'Nome de usuário';
  final usernameHint = 'Digite seu nome de usuário';

  final birthDateLabel = 'Data de nascimento';
  final birthDateHint = 'dd/mm/aaaa';

  final passwordLabel = 'Senha';
  final passwordHint = 'Crie sua senha';

  final confirmPasswordLabel = 'Confirmar senha';
  final confirmPasswordHint = 'Repita sua senha';

  // Ações e botões
  final registerButtonText = 'Criar minha conta';
  final forgotPasswordText = 'Esqueceu sua senha?';
  final alreadyHaveAccountMessage = 'Já tem uma conta?';
  final loginButtonText = 'Fazer login';

  // Termos e políticas
  final termsAgreementText =
      'Ao marcar esta caixa, você concorda com nossos Termos de Uso e Política de Privacidade.';
  final termsOfUseLabel = 'Termos de Uso';
  final privacyPolicyLabel = 'Política de Privacidade';
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

class _AboutTexts {
  const _AboutTexts();

  final aboutAdoleserTitle = 'Sobre o Adoleser';
  final aboutAdoleserParagraph =
      'O AdoleSer é um núcleo pensado para o cuidado integral de adolescentes e suas famílias, composto por uma médica hebiatra, uma psiquiatra, uma professora de enfermagem e uma professora de terapia ocupacional da Universidade Federal de São Carlos. \n\n Entre suas ações, está a discussão de assuntos relacionados a adolescência, o apoio a rede para os atendimentos e a participação e coordenação do grupo Juntos pelas Adolescências, um grupo intersetorial que tem por objetivo discutir casos complexos, fornecer suporte em rede e pensar em propostas de melhoria para a população adolescente de São Carlos.';

  final aboutPETBCCTitle = 'Sobre o PET BCC UFSCar';
  final aboutPETBCCParagraph =
      'O PET BCC UFSCar (Programa de Educação Tutorial do Bacharelado em Ciência da Computação da Universidade Federal de São Carlos) é um grupo formado por estudantes de graduação que desenvolve atividades integrando ensino, pesquisa e extensão. Coordenado por um professor tutor e vinculado ao MEC, o grupo tem como objetivo complementar a formação acadêmica, técnica e humana dos alunos, contribuindo também com a comunidade universitária e externa. \n\n Os petianos do BCC realizam projetos nas áreas de tecnologia, educação, responsabilidade social e divulgação científica. Organizam eventos, ministram minicursos, produzem conteúdos didáticos, desenvolvem sistemas e participam ativamente da vida acadêmica da UFSCar. O PET BCC também promove o crescimento pessoal e profissional dos seus membros, incentivando a autonomia, o trabalho em equipe e o pensamento crítico.';
}
