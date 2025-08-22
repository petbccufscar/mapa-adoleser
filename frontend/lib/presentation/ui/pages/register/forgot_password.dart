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

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  Future<void> _submitEmail() async {
    if (_formKey.currentState?.validate() ?? false) {
      final auth = context.read<AuthProvider>();

      await auth.forgotPasswordEmail(_emailController.text);

      if (auth.success && mounted) {
        page = 1;
      }
    }
  }

  Future<void> _submitCode() async {
    if (_formKey.currentState?.validate() ?? false) {
      final auth = context.read<AuthProvider>();

      await auth.forgotPasswordEmail(_codeController.text);

      if (auth.success && mounted) {
        page = 2;
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
                    if (page == 0) ...[
                      Text(AppTexts.forgotPassword.title,
                          style: Theme.of(context).textTheme.headlineMedium),
                      CustomTextField(
                          label: AppTexts.forgotPassword.emailLabel,
                          hint: AppTexts.forgotPassword.emailHint,
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          validator: Validators.isEmail),
                      if (auth.error != null)
                        Text(
                          auth.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      CustomButton(
                        text: AppTexts.forgotPassword.emailSubmit,
                        onPressed: auth.isLoading ? null : _submitEmail,
                      ),
                    ]
                    else if(page == 1)...[
                      Text(AppTexts.forgotPassword.title,
                          style: Theme.of(context).textTheme.headlineMedium),
                      CustomTextField(
                          label: AppTexts.forgotPassword.codeLabel,
                          controller: _codeController,
                          textInputAction: TextInputAction.next,
                          validator: Validators.isNotEmpty),
                      if (auth.error != null)
                        Text(
                          auth.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      CustomButton(
                        text: AppTexts.forgotPassword.emailSubmit,
                        onPressed: auth.isLoading ? null : _submitCode,
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
