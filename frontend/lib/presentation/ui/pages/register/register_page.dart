import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_password_fiel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final auth = context.read<AuthProvider>();

      await auth.register(_emailController.text, _nameController.text,
          DateTime.now(), _passwordController.text);

      if (auth.isLoggedIn && mounted) {
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    final isLoggedIn = auth.isLoggedIn;

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: isLoggedIn)
          : null,
      body: Center(
        child: SingleChildScrollView(
          child: ResponsivePageWrapper(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 15,
                  children: [
                    Text(AppTexts.register.title,
                        style: Theme.of(context).textTheme.headlineMedium),
                    CustomTextField(
                        label: AppTexts.register.emailLabel,
                        hint: AppTexts.register.emailHint,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        validator: Validators.isEmail),
                    CustomTextField(
                        label: AppTexts.register.nameLabel,
                        hint: AppTexts.register.nameHint,
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        validator: Validators.isNotEmpty),
                    CustomPasswordField(
                      label: AppTexts.register.passwordLabel,
                      hint: AppTexts.register.passwordHint,
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                      showPasswordStrength: true,
                      validator: Validators.isValidPassword,
                    ),
                    CustomPasswordField(
                      label: AppTexts.register.confirmPasswordLabel,
                      hint: AppTexts.register.confirmPasswordHint,
                      controller: _confirmPasswordController,
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validators.passwordsMatch(
                        value,
                        _passwordController.text,
                      ),
                      onFieldSubmitted: (_) => _submit(),
                    ),
                    if (auth.error != null)
                      Text(
                        auth.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    CustomButton(
                      text: AppTexts.register.registerButton,
                      onPressed: auth.isLoading ? null : _submit,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 5,
                      children: [
                        Text(AppTexts.register.registered),
                        ActionText(
                          text: AppTexts.register.loginAccount,
                          action: () => {context.go("/login")},
                          underlined: true,
                          boldOnHover: true,
                        ),
                      ],
                    )
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
