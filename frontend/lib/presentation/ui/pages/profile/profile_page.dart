import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/domain/models/adress_response_model.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/cep_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_date_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _dateController;
  late TextEditingController _cepController;
  late TextEditingController _addressController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    _dateController = TextEditingController(text: "12/02/2004");
    _cepController = TextEditingController(text: "13180-220");
    _addressController = TextEditingController(text: "Rua da Alegria");
    _nameController = TextEditingController(text: "Vinícius Martins Cotrim");
    _emailController = TextEditingController(text: "vini.cotrim@hotmail.com");
    _usernameController = TextEditingController(text: "coutrims");

    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _cepController.dispose();
    _addressController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    _usernameController.text = authProvider.user!.username;
    _emailController.text = authProvider.user!.email;
    _nameController.text = authProvider.user!.name;
    _cepController.text = authProvider.user!.cep;

    List<String?> stringDateList =
        authProvider.user!.birthDate.toString().split(' ')[0].split('-');

    _dateController.text =
        '${stringDateList[2]}/${stringDateList[1]}/${stringDateList[0]}';

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: authProvider.isLoggedIn),
      endDrawer: CustomDrawer(isLoggedIn: authProvider.isLoggedIn),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ResponsivePageWrapper(
              body: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Suas informações",
                        style: Theme.of(context).textTheme.headlineSmall),

                    const SizedBox(height: 16),

                    Wrap(
                      runSpacing: 16,
                      spacing: 16,
                      children: [
                        SizedBox(
                          width: 350,
                          child: CustomTextField(
                              enabled: false,
                              label: 'Usuário',
                              controller: _usernameController),
                        ),
                        SizedBox(
                          width: 350,
                          child: CustomTextField(
                              enabled: false,
                              label: 'E-mail',
                              hint: 'Digite seu e-mail',
                              controller: _emailController),
                        ),
                        SizedBox(
                          width: 350,
                          child: CustomTextField(
                              enabled: isEditing,
                              label: 'Nome',
                              hint: 'Digite seu nome',
                              controller: _nameController),
                        ),
                        SizedBox(
                          width: 350,
                          child: CustomDateField(
                              enabled: isEditing,
                              label: 'Data de Nascimento',
                              controller: _dateController,
                              validator: Validators.isValidDayMonthYear),
                        )
                      ],
                    ),

                    const SizedBox(height: 24),

                    Text("Endereço",
                        style: Theme.of(context).textTheme.headlineSmall),

                    const SizedBox(height: 16),

                    Wrap(
                      runSpacing: 16,
                      spacing: 16,
                      children: [
                        SizedBox(
                          width: 150,
                          child: CepTextField(
                            enabled: isEditing,
                            controller: _cepController,
                            onSearch: (AddressResponseModel? address) {
                              if (address != null) {
                                log(address.toString());
                                _addressController.text =
                                    '${address.street}, ${address.neighborhood}, ${address.city} - ${address.uf}';
                              } else {
                                // Mostrar mensagem de erro
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 550,
                          child: CustomTextField(
                              enabled: false,
                              label: 'Endereço',
                              controller: _addressController),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    /// Botões de ação
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 16,
                      children: [
                        CustomButton(
                          text: isEditing ? "Cancelar" : "Editar",
                          onPressed: () {
                            setState(() {
                              if (isEditing) {
                                // Cancelar edição - reverter alterações
                                _formKey.currentState?.reset();
                              }
                              isEditing = !isEditing;
                            });
                          },
                        ),
                        if (isEditing)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                setState(() => isEditing = false);
                                // TODO: salvar no backend
                                _showSuccessSnackbar();
                              }
                            },
                            child: const Text("Salvar"),
                          ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    /// Seção de segurança
                    Text("Segurança",
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        ActionText(
                            underlined: true,
                            boldOnHover: true,
                            text: 'Políticas de Privacidade',
                            action: () {}),
                        ActionText(
                            underlined: true,
                            boldOnHover: true,
                            text: 'Alterar Senha',
                            action: () {}),
                        ActionText(
                            underlined: true,
                            boldOnHover: true,
                            text: 'Excluir conta',
                            color: AppColors.warning,
                            action: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Excluir conta"),
        content: const Text(
            "Tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: implementar exclusão da conta
              _showDeleteConfirmation();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Excluir"),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Conta excluída com sucesso"),
        backgroundColor: Colors.green,
      ),
    );
    // TODO: redirecionar para login ou home
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Dados salvos com sucesso!"),
        backgroundColor: Colors.green,
      ),
    );
  }
}
