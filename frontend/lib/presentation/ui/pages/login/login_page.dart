import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/back_to_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/validators.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button.dart';

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
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackButton(),
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
                const SizedBox(height: 10),
                GestureDetector(
                    onTap: () {
                      log('CLICK: texto do esqueceu a senha');
                      // Navegar, abrir link, etc.
                    },
                    child: Text('Esqueceu a senha?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(decoration: TextDecoration.underline))),
                const SizedBox(height: 12),
                if (auth.error != null)
                  Text(
                    auth.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 12),
                CustomButton(
                    text: "Entrar", onPressed: auth.isLoading ? null : _submit)
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
            )));
  }
}
