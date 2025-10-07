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
import 'package:mapa_adoleser/providers/delete_account_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  // Chave global para validar o formulário
  final _checkAccountFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();

  // Controllers para capturar o valor dos campos de texto
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _codeController;

  int _currentIndex = 0; // Índice para controlar a etapa atual do fluxo

  int _resendTimer = 0;
  Timer? _timer;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _codeController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _codeController.dispose();
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

  // Método que dispara a exclusão da conta
  Future<void> _submitCheckAccount() async {
    // Valida os campos antes de enviar
    if (_checkAccountFormKey.currentState?.validate() ?? false) {
      // Pega o DeleteAccountProvider
      final deleteAccountProvider = context.read<DeleteAccountProvider>();

      // Chama o método do provider para excluir a conta
      await deleteAccountProvider.sendOTPCode(
          _emailController.text, _passwordController.text);

      // Se a exclusão foi bem-sucedida, redireciona para a home
      if (mounted && deleteAccountProvider.error == null) {
        setState(() {
          _currentIndex = 1;
        });

        _startTimer();
      }
    }
  }

  Future<void> _resendCode() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _resendTimer == 0) {
      final deleteAccountProvider = context.read<DeleteAccountProvider>();

      await deleteAccountProvider.sendOTPCode(
          _emailController.text, _passwordController.text);

      if (mounted && deleteAccountProvider.error == null) {
        _startTimer();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppTexts.deleteAccount.codeResendSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _submitCode() async {
    if (_codeFormKey.currentState?.validate() ?? false) {
      final deleteAccountProvider = context.read<DeleteAccountProvider>();

      await deleteAccountProvider.checkOTPCode(_codeController.text);

      if (mounted && deleteAccountProvider.error == null) {
        setState(() {
          _currentIndex = 2;
        });
      }
    }
  }

  Future<void> _deleteAccount() async {
    final deleteAccountProvider = context.read<DeleteAccountProvider>();

    await deleteAccountProvider.deleteAccount(_codeController.text);

    if (mounted && deleteAccountProvider.error == null) {
      setState(() {
        _currentIndex = 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Observa o provider para refletir mudanças de estado
    final auth = context.watch<AuthProvider>();
    final deleteAccountProvider = context.watch<DeleteAccountProvider>();

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: auth.isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: auth.isLoggedIn)
          : null,
      body: Row(
        children: [
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
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: switch (_currentIndex) {
                        0 => Form(
                            key: _checkAccountFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Título da página
                                Text(
                                  AppTexts.deleteAccount.title,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),

                                const SizedBox(height: 12),

                                // Subtítulo
                                Text(
                                  AppTexts
                                      .deleteAccount.confirmEmailAndPassword,
                                  textAlign: TextAlign.justify,
                                ),

                                const SizedBox(height: 30),

                                // Campo de e-mail
                                CustomTextField(
                                  label: AppTexts.deleteAccount.emailLabel,
                                  hint: AppTexts.deleteAccount.emailHint,
                                  controller: _emailController,
                                  textInputAction: TextInputAction.next,
                                  validator: Validators.isEmail,
                                ),

                                const SizedBox(height: 12),

                                // Campo de senha
                                CustomPasswordField(
                                  controller: _passwordController,
                                  label: AppTexts.deleteAccount.passwordLabel,
                                  hint: AppTexts.deleteAccount.passwordHint,
                                  textInputAction: TextInputAction.done,
                                  validator: Validators.isNotEmpty,
                                  onFieldSubmitted: (_) =>
                                      _submitCheckAccount(),
                                ),

                                // Exibe erro vindo do DeleteAccountProvider, se existir
                                if (deleteAccountProvider.error != null) ...[
                                  const SizedBox(height: 30),
                                  Text(
                                    deleteAccountProvider.error!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Color(0xFF4C5466)),
                                  ),
                                ],

                                const SizedBox(height: 30),

                                CustomButton(
                                  text: AppTexts.deleteAccount.sendCodeButton,
                                  onPressed: deleteAccountProvider.isLoading
                                      ? null
                                      : _submitCheckAccount,
                                ),

                                const SizedBox(height: 12),

                                CustomButton(
                                  text: AppTexts.deleteAccount.cancelButton,
                                  onPressed: () => {context.go('/perfil')},
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
                                  AppTexts.deleteAccount.title,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  AppTexts.deleteAccount.codeInstructions,
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  AppTexts.deleteAccount.codeLabel,
                                ),
                                const SizedBox(height: 12),
                                Pinput(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                if (deleteAccountProvider.error != null) ...[
                                  SizedBox(height: 30),
                                  Text(
                                    deleteAccountProvider.error!,
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                                const SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: (_resendTimer == 0 &&
                                          !deleteAccountProvider.isLoading)
                                      ? _resendCode
                                      : null,
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                          _resendTimer > 0
                                              ? Colors.grey.shade300
                                              : AppColors.pink,
                                        ),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                          _resendTimer > 0
                                              ? Colors.grey.shade600
                                              : Colors.white,
                                        ),
                                      ),
                                  child: Text(_timerText),
                                ),
                                const SizedBox(height: 12),
                                CustomButton(
                                  text: AppTexts.deleteAccount.sendCodeButton,
                                  onPressed: _codeController.text.isNotEmpty &&
                                          _codeController.text.length == 6 &&
                                          !deleteAccountProvider.isLoading
                                      ? _submitCode
                                      : null,
                                ),
                                const SizedBox(height: 12),
                                CustomButton(
                                  text: AppTexts.deleteAccount.cancelButton,
                                  onPressed: () => {context.go('/perfil')},
                                ),
                              ],
                            ),
                          ),
                        2 => Form(
                            key: _checkAccountFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Título da página
                                Text(
                                  AppTexts.deleteAccount.title,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),

                                const SizedBox(height: 30),

                                // Subtítulo
                                Text(
                                  AppTexts.deleteAccount.deleteConfirmation,
                                  textAlign: TextAlign.justify,
                                ),

                                // Exibe erro vindo do DeleteAccountProvider, se existir
                                if (deleteAccountProvider.error != null) ...[
                                  const SizedBox(height: 30),
                                  Text(
                                    deleteAccountProvider.error!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Color(0xFF4C5466)),
                                  ),
                                ],

                                const SizedBox(height: 30),

                                ElevatedButton(
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 255, 77, 77)),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white),
                                      ),
                                  onPressed: deleteAccountProvider.isLoading
                                      ? null
                                      : _deleteAccount,
                                  child: Text(
                                    AppTexts.deleteAccount.confirmButton,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                CustomButton(
                                  text: AppTexts.deleteAccount.cancelButton,
                                  onPressed: deleteAccountProvider.isLoading
                                      ? null
                                      : () {
                                          if (mounted) {
                                            context.go('/perfil');
                                          }
                                        },
                                ),
                              ],
                            ),
                          ),
                        _ => Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  AppTexts.deleteAccount.title,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  AppTexts.deleteAccount.successMessage,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 30),
                                CustomButton(
                                  text: AppTexts.deleteAccount.returnHome,
                                  onPressed: () => {context.go('/login')},
                                ),
                              ],
                            ),
                          )
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
