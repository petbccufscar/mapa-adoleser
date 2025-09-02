import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/domain/models/address_response_model.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/cep_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_date_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:mapa_adoleser/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _birthDateController;
  late final TextEditingController _cepController;
  late final TextEditingController _streetController;
  late final TextEditingController _neighborhoodController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;

  @override
  void initState() {
    _birthDateController = TextEditingController();
    _cepController = TextEditingController();
    _streetController = TextEditingController();
    _neighborhoodController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _birthDateController.dispose();
    _cepController.dispose();
    _streetController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final profileProvider = context.read<ProfileProvider>();
      final authProvider = context.read<AuthProvider>();

      String day = _birthDateController.text.split('/')[0];
      String month = _birthDateController.text.split('/')[1];
      String year = _birthDateController.text.split('/')[2];

      UserModel? user = await profileProvider.updateProfile(
          _nameController.text,
          DateTime.parse('$year-$month-$day'),
          _cepController.text);

      if (profileProvider.success && mounted) {
        authProvider.setUser(user!);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppTexts.register.successMessage),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final profileProvider = context.watch<ProfileProvider>();

    _usernameController.text = authProvider.user!.username;
    _emailController.text = authProvider.user!.email;
    _nameController.text = authProvider.user!.name;
    _cepController.text = authProvider.user!.cep;

    List<String?> stringDateList =
        authProvider.user!.birthDate.toString().split(' ')[0].split('-');

    _birthDateController.text =
        '${stringDateList[2]}/${stringDateList[1]}/${stringDateList[0]}';

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: authProvider.isLoggedIn),
      endDrawer: CustomDrawer(isLoggedIn: authProvider.isLoggedIn),
      body: SingleChildScrollView(
        child: Center(
          child: ResponsivePageWrapper(
            body: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.purple,
                            child: const Icon(Icons.person_rounded,
                                size: 60, color: Colors.white),
                          ),
                          if (isEditing)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.purple,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt,
                                      color: Colors.white, size: 20),
                                  onPressed: () {
                                    // TODO: abrir seletor de imagem
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _usernameController.text,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  Form(
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
                            CustomTextField(
                                enabled: false,
                                label: 'Usuário',
                                controller: _usernameController),
                            CustomTextField(
                                enabled: false,
                                label: 'E-mail',
                                hint: 'Digite seu e-mail',
                                controller: _emailController),
                            CustomTextField(
                                enabled: isEditing,
                                label: 'Nome',
                                hint: 'Digite seu nome',
                                keyboardType: TextInputType.name,
                                validator: Validators.isNotEmpty,
                                controller: _nameController),
                            CustomDateField(
                                enabled: isEditing,
                                label: 'Data de Nascimento',
                                controller: _birthDateController,
                                validator: Validators.isValidDayMonthYear),
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
                            CepTextField(
                              enabled: isEditing,
                              controller: _cepController,
                              onSearch: (AddressResponseModel? address) {
                                if (address != null) {
                                  _streetController.text = address.street;
                                  _neighborhoodController.text =
                                      address.neighborhood;
                                  _cityController.text = address.city;
                                  _stateController.text =
                                      '${address.state} - ${address.uf}';
                                } else {
                                  log('deu erro');
                                  profileProvider
                                      .setError('Endereço não encontrado');
                                }
                              },
                            ),
                            CustomTextField(
                                enabled: false,
                                label: 'Rua',
                                controller: _streetController),
                            CustomTextField(
                                enabled: false,
                                label: 'Bairro',
                                controller: _neighborhoodController),
                            CustomTextField(
                                enabled: false,
                                label: 'Cidade',
                                controller: _cityController),
                            CustomTextField(
                                enabled: false,
                                label: 'Estado',
                                controller: _stateController),
                          ],
                        ),

                        const SizedBox(height: 32),

                        if (profileProvider.error != null)
                          Text(
                            profileProvider.error!,
                            style: const TextStyle(color: Colors.red),
                          ),

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
                                onPressed: () => _submit(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
