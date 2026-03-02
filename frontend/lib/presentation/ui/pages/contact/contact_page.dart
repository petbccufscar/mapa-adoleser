import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/domain/models/subject_model.dart';
import 'package:mapa_adoleser/presentation/ui/modal_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
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

  late final TextEditingController _emailController;
  late final TextEditingController _nameController;
  late final TextEditingController _messageController;
  SubjectModel? selectedSubject;

  @override
  void initState() {
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _messageController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _messageController.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final contact = context.read<ContactProvider>();

      await contact.sendContact(_emailController.text, _nameController.text,
          selectedSubject!.label, _messageController.text);

      if (!mounted) return;

      if (contact.error == null) {
        _formKey.currentState?.reset();

        _emailController.clear();
        _nameController.clear();
        _messageController.clear();
        selectedSubject = null;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mensagem enviada! Em breve entraremos em contato.'),
            backgroundColor: Colors.green,
          ),
        );

        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar mensagem: ${contact.error}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final contact = context.watch<ContactProvider>();

    final List<SubjectModel> subjects = contact.subjects;

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: authProvider.isLoggedIn),
      endDrawer: CustomDrawer(isLoggedIn: authProvider.isLoggedIn),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(color: Colors.transparent),
          ),
          Expanded(
            flex: 99,
            child: SingleChildScrollView(
              padding: ResponsiveUtils.pagePadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ModalWrapper(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppTexts.contact.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                              label: AppTexts.contact.emailLabel,
                              hint: AppTexts.contact.emailHint,
                              controller: _emailController,
                              textInputAction: TextInputAction.next,
                              validator: Validators.isEmail),
                          const SizedBox(height: 12),
                          CustomTextField(
                            label: AppTexts.contact.nameLabel,
                            hint: AppTexts.contact.nameHint,
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            validator: Validators.isNotEmpty,
                          ),
                          const SizedBox(height: 12),
                          CustomDropdownField<SubjectModel>(
                            label: AppTexts.contact.subjectLabel,
                            hint: AppTexts.contact.subjectHint,
                            value: selectedSubject,
                            items: subjects,
                            onChanged: (SubjectModel? value) => {
                              setState(() {
                                selectedSubject = value;
                              })
                            },
                            getLabel: (subject) => subject.label,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            label: AppTexts.contact.messageLabel,
                            hint: AppTexts.contact.messageHint,
                            controller: _messageController,
                            textInputAction: TextInputAction.next,
                            maxLines: 8,
                            keyboardType: TextInputType.multiline,
                            validator: Validators.isNotEmpty,
                          ),
                          const SizedBox(height: 30),
                          FilledButton(
                            onPressed: contact.isLoading ? null : _submit,
                            child: Text(AppTexts.contact.sendButtonText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
