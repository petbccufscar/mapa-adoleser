import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';
import 'package:mapa_adoleser/presentation/ui/modal_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
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
  //late final TextEditingController _cepController;
  //late final TextEditingController _streetController;
  //late final TextEditingController _neighborhoodController;
  //late final TextEditingController _cityController;
  //late final TextEditingController _stateController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;

  @override
  void initState() {
    _birthDateController = TextEditingController();
    //_cepController = TextEditingController();
    //_streetController = TextEditingController();
    //_neighborhoodController = TextEditingController();
    //_cityController = TextEditingController();
    //_stateController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();

    _formKey.currentState?.reset();

    super.initState();
  }

  @override
  void dispose() {
    _birthDateController.dispose();
    //_cepController.dispose();
    //_streetController.dispose();
    //_neighborhoodController.dispose();
    //_cityController.dispose();
    //_stateController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();

    _formKey.currentState?.reset();

    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final profileProvider = context.read<ProfileProvider>();
      final authProvider = context.read<AuthProvider>();

      String day = _birthDateController.text.split('/')[0];
      String month = _birthDateController.text.split('/')[1];
      String year = _birthDateController.text.split('/')[2];

      // UserModel? user = await profileProvider.updateProfile(
      //     _nameController.text,
      //     DateTime.parse('$year-$month-$day'),
      //     _cepController.text);

      UserModel? user = await profileProvider.updateProfile(
          _usernameController.text,
          _nameController.text,
          DateTime.parse('$year-$month-$day'));

      if (profileProvider.success && mounted) {
        authProvider.setUser(user!);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppTexts.profile.title),
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
    //_cepController.text = authProvider.user!.cep;

    List<String?> stringDateList =
        authProvider.user!.birthDate.toString().split(' ')[0].split('-');

    _birthDateController.text =
        '${stringDateList[2]}/${stringDateList[1]}/${stringDateList[0]}';

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: authProvider.isLoggedIn),
      endDrawer: CustomDrawer(isLoggedIn: authProvider.isLoggedIn),
      body: SingleChildScrollView(
        padding: ResponsiveUtils.pagePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppTexts.profile.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 15),
                Text(
                  AppTexts.profile.subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(height: 40),
            ModalWrapper(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppTexts.profile.personalInfoTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 30),
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 450, // máx. largura por coluna
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 4,
                        mainAxisExtent: 94,
                      ),
                      children: [
                        CustomTextField(
                          enabled: false,
                          label: AppTexts.profile.emailLabel,
                          controller: _emailController,
                        ),
                        CustomTextField(
                          enabled: isEditing,
                          label: AppTexts.profile.usernameLabel,
                          hint: AppTexts.profile.usernameHint,
                          controller: _usernameController,
                          validator: Validators.isNotEmpty,
                          keyboardType: TextInputType.text,
                        ),
                        CustomTextField(
                          enabled: isEditing,
                          label: AppTexts.profile.nameLabel,
                          hint: AppTexts.profile.nameHint,
                          keyboardType: TextInputType.name,
                          validator: Validators.isNotEmpty,
                          controller: _nameController,
                        ),
                        CustomDateField(
                          enabled: isEditing,
                          label: AppTexts.profile.birthDateLabel,
                          hint: AppTexts.profile.birthDateHint,
                          controller: _birthDateController,
                          validator: Validators.isValidDayMonthYear,
                        ),
                        // CepTextField(
                        //   enabled: isEditing,
                        //   controller: _cepController,
                        //   onSearch: (AddressResponseModel? address) {
                        //     if (address != null) {
                        //       _streetController.text = address.street;
                        //       _neighborhoodController.text =
                        //           address.neighborhood;
                        //       _cityController.text = address.city;
                        //       _stateController.text =
                        //           '${address.state} - ${address.uf}';
                        //     } else {
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(
                        //           content: Text('Endereço não encontrado'),
                        //           backgroundColor: Colors.red,
                        //         ),
                        //       );
                        //     }
                        //   },
                        // ),
                        // CustomTextField(
                        //   enabled: false,
                        //   label: 'Rua',
                        //   controller: _streetController,
                        //   validator: Validators.isNotEmpty,
                        // ),
                        // CustomTextField(
                        //   enabled: false,
                        //   label: 'Bairro',
                        //   controller: _neighborhoodController,
                        //   validator: Validators.isNotEmpty,
                        // ),
                        // CustomTextField(
                        //   enabled: false,
                        //   label: 'Cidade',
                        //   controller: _cityController,
                        //   validator: Validators.isNotEmpty,
                        // ),
                        // CustomTextField(
                        //   enabled: false,
                        //   label: 'Estado',
                        //   controller: _stateController,
                        //   validator: Validators.isNotEmpty,
                        // ),
                      ],
                    ),

                    if (profileProvider.error != null) ...[
                      const SizedBox(height: 32),
                      Text(
                        profileProvider.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],

                    const SizedBox(height: 32),

                    /// Botões de ação
                    Wrap(
                      spacing: 16,
                      children: [
                        FilledButton(
                          onPressed: () {
                            setState(() {
                              if (isEditing) {
                                // Cancelar edição - reverter alterações
                                _formKey.currentState?.reset();
                              }

                              isEditing = !isEditing;
                            });
                          },
                          child: Text(isEditing
                              ? AppTexts.profile.cancelButtonText
                              : AppTexts.profile.editButtonText),
                        ),
                        if (isEditing)
                          FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () => _submit(),
                            child: Text(AppTexts.profile.saveButtonText),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ModalWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Segurança',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 30),
                  ActionText(
                    text: 'Termos de Uso e Política de Privacidade',
                    color: AppColors.purpleLight,
                    onTap: () {},
                    underlined: true,
                  ),
                  const SizedBox(height: 12),
                  ActionText(
                    text: 'Alterar senha',
                    color: AppColors.purpleLight,
                    onTap: () {
                      context.push('/alterar-senha');
                    },
                    underlined: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ModalWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Zona de Perigo',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 30),
                  ActionText(
                    text: 'Excluir minha conta',
                    color: Colors.red,
                    onTap: () {
                      context.push('/excluir-conta');
                    },
                    underlined: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
