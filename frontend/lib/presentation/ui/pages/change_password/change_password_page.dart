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
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:mapa_adoleser/providers/change_password_provider.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _checkPasswordFormKey = GlobalKey<FormState>();
  final _createPasswordFormKey = GlobalKey<FormState>();

  late final TextEditingController _passwordController;

  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmNewPasswordController;

  int _currentIndex = 0;

  @override
  void initState() {
    _newPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _passwordController.dispose();
    _confirmNewPasswordController.dispose();

    super.dispose();
  }

  Future<void> _submitCurrentPassword() async {
    if (_checkPasswordFormKey.currentState?.validate() ?? false) {
      final changePasswordProvider = context.read<ChangePasswordProvider>();

      await changePasswordProvider
          .checkCurrentPassword(_passwordController.text)
          .then((bool? valid) {
        if (valid != null && valid && mounted) {
          setState(() {
            _currentIndex = 1;
          });
        }
      });
    }
  }

  Future<void> _submitChangePassword() async {
    if (_createPasswordFormKey.currentState?.validate() ?? false) {
      final changePasswordProvider = context.read<ChangePasswordProvider>();

      await changePasswordProvider
          .changePassword(_passwordController.text, _newPasswordController.text)
          .then((bool? success) {
        if (success != null && success && mounted) {
          setState(() {
            _currentIndex = 2;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final changePasswordProvider = context.watch<ChangePasswordProvider>();

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
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: IndexedStack(
                  key: ValueKey(_currentIndex),
                  index: _currentIndex,
                  children: [
                    Form(
                      key: _checkPasswordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 10,
                        children: [
                          Text(
                            AppTexts.changePassword.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12),
                          CustomPasswordField(
                              label: AppTexts.changePassword.passwordLabel,
                              hint: AppTexts.changePassword.passwordHint,
                              controller: _passwordController,
                              validator: Validators.isNotEmpty),
                          if (changePasswordProvider.error != null) ...[
                            SizedBox(height: 6),
                            Text(
                              changePasswordProvider.error!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                          SizedBox(height: 6),
                          CustomButton(
                            text: 'Enviar',
                            onPressed: changePasswordProvider.isLoading
                                ? null
                                : _submitCurrentPassword,
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _createPasswordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 10,
                        children: [
                          Text(
                            AppTexts.changePassword.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12),
                          CustomPasswordField(
                              label: AppTexts.changePassword.newPasswordLabel,
                              hint: AppTexts.changePassword.newPasswordHint,
                              controller: _newPasswordController,
                              showPasswordStrength: true,
                              validator: Validators.isValidPassword),
                          CustomPasswordField(
                            label:
                                AppTexts.changePassword.confirmNewPasswordLabel,
                            hint:
                                AppTexts.changePassword.confirmNewPasswordHint,
                            controller: _confirmNewPasswordController,
                            validator: (value) => Validators.passwordsMatch(
                              value,
                              _newPasswordController.text,
                            ),
                          ),
                          if (changePasswordProvider.error != null) ...[
                            SizedBox(height: 6),
                            Text(
                              changePasswordProvider.error!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                          SizedBox(height: 6),
                          CustomButton(
                            text: 'Enviar',
                            onPressed: changePasswordProvider.isLoading
                                ? null
                                : _submitChangePassword,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 10,
                      children: [
                        Text(
                          AppTexts.changePassword.successMessage,
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        Text(
                          AppTexts.changePassword.successDescription,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 6),
                        ActionText(
                          text: AppTexts.changePassword.returnHome,
                          action: () => context.go("/"),
                          underlined: true,
                          boldOnHover: true,
                          alignment: TextAlign.center,
                        ),
                      ],
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
