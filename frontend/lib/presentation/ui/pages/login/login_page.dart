import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';
import 'package:mapa_adoleser/presentation/ui/modal_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/check_box.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_password_fiel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:mapa_adoleser/providers/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart'
    hide ResponsiveUtils;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late bool rememberMe;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    rememberMe = false;

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

      if (loginProvider.error == null && mounted) {
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
      endDrawer: CustomDrawer(isLoggedIn: authProvider.isLoggedIn),
      body: Row(
        children: [
          if (ResponsiveBreakpoints.of(context).largerOrEqualTo('LARGE_TABLET'))
            Expanded(
              flex: 99,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft, // início do gradiente
                    end: Alignment.bottomRight, // fim do gradiente
                    colors: [
                      AppColors.pinkLight,
                      AppColors.pink,
                      AppColors.purple,
                      AppColors.purpleLight,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/ADOLESER_1.png',
                        height: 160,
                        width: 200,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppTexts.login.welcome,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: AppColors.textLight),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        AppTexts.login.welcomeSubtitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.textLight),
                      )
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            flex: 1,
            child: Container(color: Colors.transparent),
          ),
          Expanded(
            flex: 99,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ModalWrapper(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(AppTexts.login.title,
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          const SizedBox(height: 30),
                          CustomTextField(
                              label: AppTexts.login.emailLabel,
                              hint: AppTexts.login.emailHint,
                              controller: _emailController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              validator: Validators.isNotEmpty),
                          const SizedBox(height: 12),
                          CustomPasswordField(
                            label: AppTexts.login.passwordLabel,
                            hint: AppTexts.login.passwordHint,
                            controller: _passwordController,
                            validator: Validators.isNotEmpty,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submit(),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              CustomCheckbox(
                                value: rememberMe,
                                label: Text(AppTexts.login.rememberMe),
                                onChanged: (val) {
                                  setState(() {
                                    rememberMe = val;
                                  });
                                },
                              ),
                              ActionText(
                                text: AppTexts.login.forgotPassword,
                                onTap: () {
                                  context.go("/recuperar-senha");
                                },
                                underlined: true,
                                boldOnHover: true,
                                color: AppColors.purpleLight,
                              ),
                            ],
                          ),
                          if (loginProvider.error != null) ...[
                            const SizedBox(height: 30),
                            Text(
                              loginProvider.error!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                          const SizedBox(height: 30),
                          CustomButton(
                            text: AppTexts.login.loginButton,
                            onPressed: loginProvider.isLoading ? null : _submit,
                          ),
                          const SizedBox(height: 30),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            spacing: 5,
                            children: [
                              Text(AppTexts.login.unregistered),
                              ActionText(
                                text: AppTexts.login.createAccount,
                                onTap: () {
                                  context.go("/cadastro");
                                },
                                underlined: true,
                                boldOnHover: true,
                                color: AppColors.purpleLight,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
