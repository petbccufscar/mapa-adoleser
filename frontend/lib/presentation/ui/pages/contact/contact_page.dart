import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/domain/models/subject_model.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_dropdown_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:mapa_adoleser/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();
  Subject? selectedSubject;

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final contact = context.read<ContactProvider>();

      await contact.sendContact(_emailController.text, _nameController.text,
          selectedSubject!.label, _messageController.text);

      if (!mounted) return;

      context.go(
        '/contato/envio',
        extra: {
          'title': contact.success ? "Mensagem enviada" : "Erro",
          'message': contact.success
              ? "Fique de olho em seu email. Em breve entraremos em contato!"
              : contact.error,
        },
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final contact = context.watch<ContactProvider>();

    final List<Subject> subjects = contact.subjects;

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
                    Text(AppTexts.help.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    CustomTextField(
                        label: AppTexts.help.emailLabel,
                        hint: AppTexts.help.emailHint,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        validator: Validators.isEmail),
                    CustomTextField(
                      label: AppTexts.help.nameLabel,
                      hint: AppTexts.help.nameHint,
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      validator: Validators.isNotEmpty,
                    ),
                    CustomDropdownField<Subject>(
                      label: AppTexts.help.subjectLabel,
                      hint: AppTexts.help.subjectHint,
                      value: selectedSubject,
                      items: subjects,
                      onChanged: (Subject? value) => {
                        setState(() {
                          selectedSubject = value;
                        })
                      },
                      getLabel: (subject) => subject.label,
                    ),
                    CustomTextField(
                      label: AppTexts.help.messageLabel,
                      hint: AppTexts.help.messageHint,
                      controller: _messageController,
                      textInputAction: TextInputAction.next,
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      validator: Validators.isNotEmpty,
                    ),
                    CustomButton(
                      text: AppTexts.help.helpButton,
                      onPressed: contact.isLoading ? null : _submit,
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
