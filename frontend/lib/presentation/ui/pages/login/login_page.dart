import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_password_fiel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:mapa_adoleser/providers/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final loginProvider = context.read<LoginProvider>();
      final authProvider = context.read<AuthProvider>();

      await loginProvider
          .login(_emailController.text, _passwordController.text)
          .then((UserModel? model) {
        if (model != null) {
          authProvider.setUser(model);
        }
      });

      if (loginProvider.success && mounted) {
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final loginProvider = context.watch<LoginProvider>();

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: authProvider.isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: authProvider.isLoggedIn)
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
                    Text(AppTexts.login.title,
                        style: Theme.of(context).textTheme.headlineMedium),
                    SizedBox(height: 5),
                    CustomTextField(
                        label: AppTexts.login.emailLabel,
                        hint: AppTexts.login.emailHint,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        validator: Validators.isEmail),
                    CustomPasswordField(
                      label: AppTexts.login.passwordLabel,
                      hint: AppTexts.login.passwordHint,
                      controller: _passwordController,
                      validator: Validators.isNotEmpty,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 5,
                      children: [
                        ActionText(
                          text: AppTexts.login.forgotPassword,
                          action: () => {context.go("/recuperar-senha")},
                          underlined: true,
                          boldOnHover: true,
                        ),
                      ],
                    ),
                    if (loginProvider.error != null)
                      Text(
                        loginProvider.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    CustomButton(
                      text: AppTexts.login.loginButton,
                      onPressed: loginProvider.isLoading ? null : _submit,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 5,
                      children: [
                        Text(AppTexts.login.unregistered),
                        ActionText(
                          text: AppTexts.login.createAccount,
                          action: () => {context.go("/cadastro")},
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
