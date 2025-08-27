import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/presentation/validators.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ExcluePage extends StatefulWidget {
  const ExcluePage({super.key});

  @override
  State<ExcluePage> createState() => _ExcluePageState();
}

class _ExcluePageState extends State<ExcluePage> {
  // Chave global para validar o formulário
  final _formKey = GlobalKey<FormState>();

  // Controllers para capturar o valor dos campos de texto
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Método que dispara a exclusão da conta
  Future<void> _submit() async {
    // Valida os campos antes de enviar
    if (_formKey.currentState?.validate() ?? false) {
      // Pega o AuthProvider
      final auth = context.read<AuthProvider>();

      // Chama o método do provider para excluir a conta
      await auth.deleteAccount(
        _emailController.text,
        _passwordController.text,
      );

      // Se a exclusão foi bem-sucedida, redireciona para a home
      if (auth.isDeleted && mounted) {
        context.go('/'); // volta pra home
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Observa o provider para refletir mudanças de estado
    final auth = context.watch<AuthProvider>();
    final isLoggedIn = auth.isLoggedIn;

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: isLoggedIn)
          : null,
      body: SingleChildScrollView(
        child: Center(
          child: ResponsivePageWrapper(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 15,
                  children: [
                    const SizedBox(height: 80),

                    // Título da página
                    Text(
                      "Excluir conta",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),

                    // Subtítulo
                    const Text(
                      "Confirme seu email e senha. Você receberá um código de confirmação em seu email.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF4C5466)),
                    ),
                    const SizedBox(height: 16),

                    // Campo de e-mail
                    CustomTextField(
                      label: "E-mail",
                      hint: "Digite seu e-mail",
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      validator: Validators.isEmail,
                    ),

                    // Campo de senha
                    CustomTextField(
                      label: "Senha",
                      hint: "Digite sua senha",
                      controller: _passwordController,
                      obscureText: true,
                      validator: Validators.isNotEmpty,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                    ),

                    // Exibe erro vindo do AuthProvider, se existir
                    if (auth.error != null)
                      Text(
                        auth.error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Color(0xFF4C5466)),
                      ),

                    CustomButton(
                      text: "Enviar",
                      onPressed: auth.isLoading ? null : _submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
