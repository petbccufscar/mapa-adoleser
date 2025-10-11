import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/presentation/ui/modal_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/check_box.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_date_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_password_fiel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:mapa_adoleser/providers/register_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart'
    hide ResponsiveUtils;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _birthDateController;
  late bool acceptTerms;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _birthDateController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    acceptTerms = false;

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    _birthDateController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final registerProvider = context.read<RegisterProvider>();

      String day = _birthDateController.text.split('/')[0];
      String month = _birthDateController.text.split('/')[1];
      String year = _birthDateController.text.split('/')[2];

      await registerProvider.register(
          _emailController.text,
          _usernameController.text,
          _nameController.text,
          DateTime.parse('$year-$month-$day'),
          _passwordController.text,
          acceptTerms);

      if (registerProvider.error == null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppTexts.register.successMessage),
            backgroundColor: Colors.green,
          ),
        );

        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final registerProvider = context.watch<RegisterProvider>();

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
                      AppColors.pink,
                      AppColors.pinkLight,
                      AppColors.purpleLight,
                      AppColors.purple,
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
                        AppTexts.register.welcomeMessage,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: AppColors.textLight),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        AppTexts.register.welcomeSubtitle,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ModalWrapper(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(AppTexts.register.title,
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          const SizedBox(height: 30),
                          CustomTextField(
                              label: AppTexts.register.emailLabel,
                              hint: AppTexts.register.emailHint,
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              textInputAction: TextInputAction.next,
                              validator: Validators.isEmail),
                          const SizedBox(height: 12),
                          CustomTextField(
                              label: AppTexts.register.usernameLabel,
                              hint: AppTexts.register.usernameHint,
                              controller: _usernameController,
                              textInputAction: TextInputAction.next,
                              validator: Validators.isNotEmpty),
                          const SizedBox(height: 12),
                          CustomTextField(
                              label: AppTexts.register.nameLabel,
                              hint: AppTexts.register.nameHint,
                              keyboardType: TextInputType.name,
                              controller: _nameController,
                              textInputAction: TextInputAction.next,
                              validator: Validators.isNotEmpty),
                          const SizedBox(height: 12),
                          CustomDateField(
                            label: AppTexts.register.birthDateLabel,
                            hint: AppTexts.register.birthDateHint,
                            controller: _birthDateController,
                            textInputAction: TextInputAction.next,
                            validator: Validators.isValidDayMonthYear,
                          ),
                          const SizedBox(height: 12),
                          CustomPasswordField(
                            label: AppTexts.register.passwordLabel,
                            hint: AppTexts.register.passwordHint,
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                            showPasswordStrength: true,
                            validator: Validators.isValidPassword,
                          ),
                          const SizedBox(height: 12),
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
                          const SizedBox(height: 30),
                          CustomCheckbox(
                            value: acceptTerms,
                            label: Expanded(
                              child: Wrap(
                                children: [
                                  Text(AppTexts.register.termsAgreementText),
                                ],
                              ),
                            ),
                            onChanged: (val) {
                              setState(() {
                                acceptTerms = val;
                              });
                            },
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 15,
                            runSpacing: 10,
                            direction: Axis.horizontal,
                            children: [
                              ActionText(
                                text: AppTexts.register.termsOfUseLabel,
                                onTap: () {
                                  context.go('/');
                                },
                                underlined: true,
                                boldOnHover: true,
                              ),
                              ActionText(
                                text: AppTexts.register.privacyPolicyLabel,
                                onTap: () {
                                  context.go('/');
                                },
                                underlined: true,
                                boldOnHover: true,
                              ),
                            ],
                          ),
                          if (registerProvider.error != null) ...[
                            const SizedBox(height: 30),
                            Text(
                              registerProvider.error!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          const SizedBox(height: 30),
                          FilledButton(
                            onPressed:
                                registerProvider.isLoading ? null : _submit,
                            child: Text(AppTexts.register.registerButtonText),
                          ),
                          SizedBox(height: 30),
                          Wrap(
                            spacing: 5,
                            alignment: WrapAlignment.center,
                            children: [
                              Text(AppTexts.register.alreadyHaveAccountMessage),
                              ActionText(
                                text: AppTexts.register.loginButtonText,
                                onTap: () {
                                  context.go("/login");
                                },
                                underlined: true,
                                boldOnHover: true,
                                color: AppColors.purpleLight,
                              ),
                            ],
                          ),
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
