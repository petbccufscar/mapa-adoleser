import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/validators.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final auth = context.read<AuthProvider>();

      await auth.login(_emailController.text, _passwordController.text);

      if (auth.isLoggedIn && mounted) {
        context.go('/');
      }
    }
  }

  // String? selectedOption;
  // final List<String> options = const ['Academia', 'Parque', 'Praça'];

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
        appBar: CustomAppBar(isLoggedIn: auth.isLoggedIn),
        body: ResponsivePageWrapper(
            child: Center(
                child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Entre com sua conta",
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 20),
                  CustomTextField(
                      label: 'E-mail',
                      hint: 'Digite seu e-mail',
                      controller: _emailController,
                      validator: Validators.isEmail),
                  const SizedBox(height: 12),
                  CustomTextField(
                      label: 'Senha',
                      hint: 'Digite sua senha',
                      controller: _passwordController,
                      obscureText: true,
                      validator: Validators.isNotEmpty),
                  const SizedBox(height: 12),
                  ActionText(
                    text: "Esqueceu a senha?",
                    action: () => {context.go("/sobre")},
                    underlined: true,
                    boldOnHover: true,
                  ),
                  const SizedBox(height: 12),
                  if (auth.error != null)
                    Text(
                      auth.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 12),
                  CustomButton(
                      text: "Entrar",
                      onPressed: auth.isLoading ? null : _submit),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text("Ainda não tem uma conta?"),
                      ActionText(
                        text: "Crie uma!",
                        action: () => {context.go("/ajuda")},
                        underlined: true,
                        boldOnHover: true,
                      ),
                    ],
                  )

                  // CustomDropdownField(
                  //   hint: "Categoria",
                  //   label: 'Selecione uma categoria',
                  //   value: selectedOption,
                  //   items: options
                  //       .map((op) => DropdownMenuItem(
                  //             value: op,
                  //             child: Text(op),
                  //           ))
                  //       .toList(),
                  //   onChanged: (value) => {},
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Selecione uma categoria';
                  //     }
                  //
                  //     return null;
                  //   },
                  // ),
                ],
              )),
        ))));
  }
}
