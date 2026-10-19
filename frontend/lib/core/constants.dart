/// Contém constantes reutilizáveis na aplicação, como strings, tamanhos, margens, etc.
class ResponsivePaddings {
  static const double modalHorizontalPhone = 16.0;
  static const double modalHorizontalTablet = 32.0;
  static const double modalHorizontalTableLarge = 32.0;
  static const double modalHorizontalDesktop = 32.0;
  static const double modalHorizontalDesktopLarge = 32.0;

  static const double modalVerticalPhone = 20.0;
  static const double modalVerticalTablet = 32.0;
  static const double modalVerticalTableLarge = 32.0;
  static const double modalVerticalDesktop = 32.0;
  static const double modalVerticalDesktopLarge = 32.0;

  static const double horizontalPhone = 16.0;
  static const double horizontalTablet = 32.0;
  static const double horizontalTableLarge = 64.0;
  static const double horizontalDesktop = 192.0;
  static const double horizontalDesktopLarge = 320.0;

  static const double verticalPhone = 16.0;
  static const double verticalTablet = 32.0;
  static const double verticalTableLarge = 32.0;
  static const double verticalDesktop = 32.0;
  static const double verticalDesktopLarge = 32.0;
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
  static const double footerVerticalPadding = 30;
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
  final verifyPasswordButtonText = 'Enviar';
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
  final termsLabel = 'Termos de Uso e Política de Privacidade';
}

/// Substitui a classe _HomeTexts existente (dentro do seu constants.dart).
class _HomeTexts {
  const _HomeTexts();

  // Sobre
  final aboutTitle = 'Sobre o Mapa Adoleser';
  final aboutText =
      'O Mapa Adoleser é uma plataforma criada para aproximar a comunidade de São Carlos dos espaços da cidade que podem fazer parte do seu dia a dia. A proposta é facilitar o acesso a informações sobre lugares onde é possível se divertir, aprender, conviver e cuidar de si, de um jeito simples e acessível para todo mundo. \n\n Aqui você encontra a localização de cada espaço, como chegar, os horários de funcionamento e as atividades disponíveis. Tudo reunido em um só lugar, com dados organizados e revisados com frequência, para que você descubra novas opções e escolha com mais facilidade o que combina com o seu momento e com o seu estilo.';
  final aboutButton = 'Saiba mais sobre o projeto';

  // Números
  final knowTitle = 'Conheça um local que lhe fará bem';
  final knowText =
      'Use o mapa e os filtros da página de pesquisa para achar um bom lugar para você, perto de casa ou da escola.';
  final numbers = const [
    ('120', 'locais cadastrados'),
    ('35', 'bairros atendidos'),
    ('8', 'tipos de atividade'),
    ('60', 'com acesso gratuito'),
  ];
  final numbersUpdated = 'Dados atualizados em outubro de 2026';

  // Como usar
  final howToTitle = 'Como usar';
  final howToSteps = const [
    (
      'Busque',
      'Digite o nome do local, o bairro ou a atividade que você quer fazer.'
    ),
    (
      'Filtre',
      'Refine por tipo de atividade, horário de funcionamento e se o acesso é gratuito.'
    ),
    ('Vá até lá', 'Veja endereço, telefone e o caminho no mapa.'),
  ];

  // Um mapa para chamar de seu
  final mapTitle = 'Um mapa para chamar de seu';
  final mapText =
      'A cidade tem mais opções do que parece. O Mapa Adoleser ajuda você a encontrá-las, no seu tempo e do seu jeito.';
  final mapTopics = const [
    'Opções para todos os gostos e estilos',
    'Espaços para ir sozinho ou com os amigos',
    'Informações claras, reunidas em um só lugar',
    'Locais acessíveis e abertos à comunidade',
  ];
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
