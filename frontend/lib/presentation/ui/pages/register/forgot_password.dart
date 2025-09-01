import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
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
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  int page = 0;
  int _resendTimer = 0;
  Timer? _timer;
  String? _userEmail;

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

  Future<void> _submitEmail() async {
    if (_formKey.currentState?.validate() ?? false) {
      final auth = context.read<AuthProvider>();

      await auth.forgotPasswordEmail(_emailController.text);

      if (mounted && auth.error == null) {
        _userEmail = _emailController.text;
        setState(() {
          page = 1;
        });
        _startTimer();
      }
    }
  }

  Future<void> _submitCode() async {
    if (_formKey.currentState?.validate() ?? false) {
      final auth = context.read<AuthProvider>();

      await auth.forgotPasswordCode(_codeController.text);

      if (mounted && auth.error == null) {
        setState(() {
          page = 2;
        });
      }
    }
  }

  Future<void> _resendCode() async {
    if (_userEmail != null) {
      final auth = context.read<AuthProvider>();

      await auth.forgotPasswordEmail(_userEmail!);

      if (mounted && auth.error == null) {
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

  Future<void> _submitNewPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      final auth = context.read<AuthProvider>();

      if (_userEmail == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: e-mail não encontrado.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      await auth.resetPassword(
        _userEmail!,
        _passwordController.text,
      );

      if (mounted && auth.error == null) {
        setState(() {
          page = 3;
        });
      }
    }
  }

  String get _timerText {
    if (_resendTimer > 0) {
      return 'Reenviar (${_resendTimer}s)';
    }
    return 'Reenviar';
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
                    if (page == 0) ...[
                      Text(
                        AppTexts.forgotPassword.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      CustomTextField(
                        label: AppTexts.forgotPassword.emailLabel,
                        hint: AppTexts.forgotPassword.emailHint,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        validator: Validators.isEmail,
                      ),
                      if (auth.error != null)
                        Text(
                          auth.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      CustomButton(
                        text: AppTexts.forgotPassword.emailSubmit,
                        onPressed: auth.isLoading ? null : _submitEmail,
                      ),
                    ] else if (page == 1) ...[
                      Text(
                        AppTexts.forgotPassword.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(AppTexts.forgotPassword.codeLabel),

                      Pinput(
                        controller: _codeController,
                        length: 6,
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
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
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length != 6) {
                            return 'Por favor, digite o código de 6 dígitos';
                          }
                          return null;
                        },
                        onCompleted: (pin) {
                          _submitCode();
                        },
                      ),

                      if (auth.error != null)
                        Text(
                          auth.error!,
                          style: const TextStyle(color: Colors.red),
                        ),

                      ElevatedButton(
                        onPressed: (_resendTimer == 0 && !auth.isLoading) ? _resendCode : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _resendTimer > 0
                              ? Colors.grey.shade300
                              : AppColors.pink,
                          foregroundColor: _resendTimer > 0
                              ? Colors.grey.shade600
                              : Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(_timerText),
                      ),

                      CustomButton(
                        text: AppTexts.forgotPassword.emailSubmit,
                        onPressed: _submitCode,
                        enabled: !auth.isLoading,
                      ),
                    ] else if (page == 2) ...[
                      Text(
                        AppTexts.forgotPassword.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      CustomPasswordField(
                        label: AppTexts.forgotPassword.passwordLabel,
                        hint: AppTexts.forgotPassword.newPassword,
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                        showPasswordStrength: true,
                        validator: Validators.isValidPassword,
                      ),
                      CustomPasswordField(
                        label: AppTexts.forgotPassword.passwordAgainLabel,
                        hint: AppTexts.forgotPassword.newPasswordAgain,
                        controller: _confirmPasswordController,
                        textInputAction: TextInputAction.done,
                        validator: (value) => Validators.passwordsMatch(
                          value,
                          _passwordController.text,
                        ),
                      ),
                      if (auth.error != null)
                        Text(
                          auth.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      CustomButton(
                        text: AppTexts.forgotPassword.emailSubmit,
                        onPressed: auth.isLoading ? null : _submitNewPassword,
                      ),
                    ] else if (page == 3) ...[
                      Column(
                        children: [
                          Text(
                            AppTexts.forgotPassword.title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppTexts.forgotPassword.successMessage,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 20),
                          ActionText(
                            text: AppTexts.forgotPassword.returnLogin,
                            action: () => context.go("/login"),
                            underlined: true,
                            boldOnHover: true,
                          ),
                        ],
                      ),
                    ],
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