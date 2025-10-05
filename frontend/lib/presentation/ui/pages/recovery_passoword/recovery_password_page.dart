import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/presentation/ui/modal_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_password_fiel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:mapa_adoleser/providers/recovery_password_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({super.key});

  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final _emailFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _codeController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  int _currentIndex = 0;

  int _resendTimer = 0;
  Timer? _timer;

  @override
  initState() {
    _emailController = TextEditingController();
    _codeController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _timer?.cancel();

    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _resendTimer = 60;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String get _timerText {
    if (_resendTimer > 0) {
      return 'Reenviar (${_resendTimer}s)';
    }
    return 'Reenviar';
  }

  Future<void> _submitEmail() async {
    if (_emailFormKey.currentState?.validate() ?? false) {
      final recoveryPasswordProvider = context.read<RecoveryPasswordProvider>();

      await recoveryPasswordProvider.sendOTPCode(_emailController.text);

      if (mounted && recoveryPasswordProvider.error == null) {
        setState(() {
          _currentIndex = 1;
        });

        _startTimer();
      }
    }
  }

  Future<void> _resendCode() async {
    if (_emailController.text.isNotEmpty) {
      final recoveryPasswordProvider = context.read<RecoveryPasswordProvider>();

      await recoveryPasswordProvider.sendOTPCode(_emailController.text);

      if (mounted && recoveryPasswordProvider.error == null) {
        _startTimer();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Código reenviado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _submitCode() async {
    if (_codeFormKey.currentState?.validate() ?? false) {
      final recoveryPasswordProvider = context.read<RecoveryPasswordProvider>();

      await recoveryPasswordProvider.checkOTPCode(_codeController.text);

      if (mounted && recoveryPasswordProvider.error == null) {
        setState(() {
          _currentIndex = 2;
        });
      }
    }
  }

  Future<void> _submitNewPassword() async {
    if (_passwordFormKey.currentState?.validate() ?? false) {
      final recoveryPasswordProvider = context.read<RecoveryPasswordProvider>();

      await recoveryPasswordProvider.resetPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (mounted && recoveryPasswordProvider.error == null) {
        setState(() {
          _currentIndex = 3;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final recoveryPasswordProvider = context.watch<RecoveryPasswordProvider>();
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: authProvider.isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: authProvider.isLoggedIn)
          : null,
      body: Center(
        child: SingleChildScrollView(
          child: ResponsivePageWrapper(
            child: ModalWrapper(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: switch (_currentIndex) {
                  0 => Form(
                      key: _emailFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppTexts.recoveryPassword.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(height: 30),
                          Text(AppTexts.recoveryPassword.instructions),
                          SizedBox(height: 30),
                          CustomTextField(
                            label: AppTexts.recoveryPassword.emailLabel,
                            hint: AppTexts.recoveryPassword.emailHint,
                            controller: _emailController,
                            textInputAction: TextInputAction.done,
                            validator: Validators.isEmail,
                          ),
                          if (recoveryPasswordProvider.error != null) ...[
                            SizedBox(height: 30),
                            Text(
                              recoveryPasswordProvider.error!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          SizedBox(height: 30),
                          CustomButton(
                            text: AppTexts.recoveryPassword.emailSubmit,
                            onPressed: recoveryPasswordProvider.isLoading
                                ? null
                                : _submitEmail,
                          ),
                          SizedBox(height: 8),
                          CustomButton(
                            text: AppTexts.recoveryPassword.cancel,
                            onPressed: () => {context.go('/login')},
                          ),
                        ],
                      ),
                    ),
                  1 => Form(
                      key: _codeFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppTexts.recoveryPassword.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(height: 30),
                          Text(AppTexts.recoveryPassword.codeLabel),
                          SizedBox(height: 12),
                          Pinput(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            controller: _codeController,
                            length: 6,
                            defaultPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            errorPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            focusedPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            submittedPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          if (recoveryPasswordProvider.error != null) ...[
                            SizedBox(height: 30),
                            Text(
                              recoveryPasswordProvider.error!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: (_resendTimer == 0 &&
                                    !recoveryPasswordProvider.isLoading)
                                ? _resendCode
                                : null,
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style
                                ?.copyWith(
                                  backgroundColor: WidgetStateProperty.all(
                                    _resendTimer > 0
                                        ? Colors.grey.shade300
                                        : AppColors.pink,
                                  ),
                                  foregroundColor: WidgetStateProperty.all(
                                    _resendTimer > 0
                                        ? Colors.grey.shade600
                                        : Colors.white,
                                  ),
                                ),
                            child: Text(_timerText),
                          ),
                          SizedBox(height: 8),
                          CustomButton(
                              text: AppTexts.recoveryPassword.emailSubmit,
                              onPressed: _codeController.text.isNotEmpty &&
                                      _codeController.text.length == 6 &&
                                      !recoveryPasswordProvider.isLoading
                                  ? _submitCode
                                  : null),
                          SizedBox(height: 8),
                          CustomButton(
                            text: AppTexts.recoveryPassword.cancel,
                            onPressed: () => {context.go('/login')},
                          ),
                        ],
                      ),
                    ),
                  2 => Form(
                      key: _passwordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppTexts.recoveryPassword.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(height: 30),
                          CustomPasswordField(
                            label: AppTexts.recoveryPassword.passwordLabel,
                            hint: AppTexts.recoveryPassword.newPassword,
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                            showPasswordStrength: true,
                            validator: Validators.isValidPassword,
                          ),
                          SizedBox(height: 12),
                          CustomPasswordField(
                            label: AppTexts.recoveryPassword.passwordAgainLabel,
                            hint: AppTexts.recoveryPassword.newPasswordAgain,
                            controller: _confirmPasswordController,
                            textInputAction: TextInputAction.done,
                            validator: (value) => Validators.passwordsMatch(
                              value,
                              _passwordController.text,
                            ),
                          ),
                          if (recoveryPasswordProvider.error != null) ...[
                            SizedBox(height: 30),
                            Text(
                              recoveryPasswordProvider.error!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          SizedBox(height: 30),
                          CustomButton(
                            text: AppTexts.recoveryPassword.emailSubmit,
                            onPressed: recoveryPasswordProvider.isLoading
                                ? null
                                : _submitNewPassword,
                          ),
                          SizedBox(height: 12),
                          CustomButton(
                            text: AppTexts.recoveryPassword.cancel,
                            onPressed: () => {context.go('/login')},
                          ),
                        ],
                      ),
                    ),
                  _ => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppTexts.recoveryPassword.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          AppTexts.recoveryPassword.successMessage,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          text: AppTexts.recoveryPassword.backToLogin,
                          onPressed: () => {context.go('/login')},
                        ),
                      ],
                    ),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
