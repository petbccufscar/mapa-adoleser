import 'dart:async';
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

  int page = 0;
  int _resendTimer = 0;
  Timer? _timer;
  String? _userEmail; // Para armazenar o email do usuário

  @override
  void dispose() {
    _emailController.dispose();
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

  // Simulação para teste - remover quando conectar o banco
  String? _simulatedCode; // Código simulado que será "enviado"

  Future<void> _submitEmail() async {
    if (_formKey.currentState?.validate() ?? false) {
      final auth = context.read<AuthProvider>();

      // Simulação - gera um código aleatório de 6 dígitos para teste
      _simulatedCode = '123456'; // Você pode usar: (100000 + Random().nextInt(900000)).toString();

      print('🔥 TESTE: Código simulado enviado para ${_emailController.text}: $_simulatedCode');

      // Simula sucesso após 2 segundos (como se fosse uma requisição)
      await Future.delayed(const Duration(seconds: 2));

      // Simula sucesso do AuthProvider
      // await auth.forgotPasswordEmail(_emailController.text);

      if (mounted) {
        _userEmail = _emailController.text; // Salva o email
        setState(() {
          page = 1;
        });
        _startTimer(); // Inicia o timer quando muda para a página do código

        // Mostra o código no console e em um SnackBar para teste
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('TESTE: Código enviado: $_simulatedCode'),
            backgroundColor: Colors.blue,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  Future<void> _submitCode() async {
    if (_formKey.currentState?.validate() ?? false) {
      final auth = context.read<AuthProvider>();

      // Simulação - verifica se o código digitado é igual ao simulado
      String enteredCode = _codeController.text;

      print('🔥 TESTE: Código digitado: $enteredCode');
      print('🔥 TESTE: Código esperado: $_simulatedCode');

      // Simula verificação após 1 segundo
      await Future.delayed(const Duration(seconds: 1));

      if (enteredCode == _simulatedCode) {
        // Código correto - vai para próxima página
        print('✅ TESTE: Código correto!');

        if (mounted) {
          setState(() {
            page = 2; // Ou navegar para página de nova senha
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Código verificado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );

          // Aqui você pode navegar para a página de redefinir senha
          // context.go('/reset-password');
        }
      } else {
        // Código incorreto
        print('❌ TESTE: Código incorreto!');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Código incorreto. Tente novamente.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _resendCode() async {
    if (_userEmail != null) {
      // Gera um novo código para teste
      _simulatedCode = '654321'; // Ou usar Random novamente

      print('🔥 TESTE: Novo código reenviado para $_userEmail: $_simulatedCode');

      // Simula reenvio após 1 segundo
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        _startTimer(); // Reinicia o timer
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('TESTE: Novo código: $_simulatedCode'),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 5),
          ),
        );
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

                      // Card de informação para teste
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              '🧪 MODO TESTE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            if (_simulatedCode != null)
                              Text(
                                'Código: $_simulatedCode',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Pinput com tamanho maior para ficar igual aos botões
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
                          // Opcional: submeter automaticamente quando completar os 6 dígitos
                          _submitCode();
                        },
                      ),

                      if (auth.error != null)
                        Text(
                          auth.error!,
                          style: const TextStyle(color: Colors.red),
                        ),

                      // Botão de reenviar com timer
                      CustomButton(
                        text: _timerText,
                        onPressed: _resendCode,
                        enabled: _resendTimer == 0 && !auth.isLoading,
                      ),

                      // Botão de validar código
                      CustomButton(
                        text: AppTexts.forgotPassword.emailSubmit,
                        onPressed: _submitCode,
                        enabled: !auth.isLoading,
                      ),
                    ]
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