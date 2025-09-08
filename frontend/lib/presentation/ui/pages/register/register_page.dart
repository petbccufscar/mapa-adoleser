import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/check_box.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_date_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_password_fiel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:mapa_adoleser/providers/register_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _birthDateController;
  late bool acceptTerms;

  @override
  void initState() {
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
                    Text(AppTexts.register.title,
                        style: Theme.of(context).textTheme.headlineMedium),
                    SizedBox(height: 5),
                    CustomTextField(
                        label: AppTexts.register.emailLabel,
                        hint: AppTexts.register.emailHint,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        validator: Validators.isEmail),
                    CustomTextField(
                        label: AppTexts.register.nameLabel,
                        hint: AppTexts.register.nameHint,
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        validator: Validators.isNotEmpty),
                    CustomDateField(
                      label: AppTexts.register.birthDateLabel,
                      hint: AppTexts.register.birthDateHint,
                      controller: _birthDateController,
                      textInputAction: TextInputAction.next,
                      validator: Validators.isValidDayMonthYear,
                    ),
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
                    SizedBox(height: 2),
                    CustomCheckbox(
                      value: acceptTerms,
                      label: Wrap(
                        children: [
                          Text(AppTexts.register.checkBoxText),
                          ActionText(
                            text: AppTexts.register.checkBoxTextTerms,
                            action: () {
                              context.go('/');
                            },
                            underlined: true,
                            boldOnHover: true,
                          )
                        ],
                      ),
                      onChanged: (val) {
                        setState(() {
                          acceptTerms = val;
                        });
                      },
                    ),
                    SizedBox(height: 2),
                    if (registerProvider.error != null)
                      Text(
                        registerProvider.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    CustomButton(
                      text: AppTexts.register.registerButton,
                      onPressed: registerProvider.isLoading ? null : _submit,
                    ),
                    Wrap(
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
