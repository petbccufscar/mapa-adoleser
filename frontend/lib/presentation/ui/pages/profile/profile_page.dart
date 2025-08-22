import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/footer.dart';
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

  // Mock data (depois puxar do provider)
  String name = "Fulano de Tal";
  String email = "fulano@gmail.com";
  String birthDate = "00/00/0000";
  String address = "Rua da Alegria, Jardim da Saúde";
  String number = "123";
  String city = "São Carlos";
  String cep = "000000-00";

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isLoggedIn = auth.isLoggedIn;

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: isLoggedIn)
          : null,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Título
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "| Perfil",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: AppColors.purple),
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// Avatar + Nome
                      Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: AppColors.purple,
                                child: const Icon(Icons.person,
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
                                        _showImagePickerDialog();
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (!isEditing)
                            TextButton(
                              onPressed: () {
                                setState(() => isEditing = true);
                              },
                              child: const Text("Alterar foto"),
                            ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      /// Formulário
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Suas informações",
                                style: Theme.of(context).textTheme.titleLarge),

                            const SizedBox(height: 16),

                            Wrap(
                              runSpacing: 16,
                              spacing: 16,
                              children: [
                                _buildField(
                                  "Nome",
                                  name,
                                  (v) => setState(() => name = v!),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nome é obrigatório';
                                    }
                                    return null;
                                  },
                                ),
                                _buildField(
                                  "Email",
                                  email,
                                  (v) => setState(() => email = v!),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email é obrigatório';
                                    }
                                    if (!value.contains('@')) {
                                      return 'Email inválido';
                                    }
                                    return null;
                                  },
                                ),
                                _buildField(
                                  "Data de nascimento",
                                  birthDate,
                                  (v) => setState(() => birthDate = v!),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Data de nascimento é obrigatória';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            Text("Endereço",
                                style: Theme.of(context).textTheme.titleLarge),

                            const SizedBox(height: 16),

                            Wrap(
                              runSpacing: 16,
                              spacing: 16,
                              children: [
                                _buildField(
                                  "Endereço",
                                  address,
                                  (v) => setState(() => address = v!),
                                  width: 400,
                                ),
                                _buildField(
                                  "Número",
                                  number,
                                  (v) => setState(() => number = v!),
                                  width: 150,
                                ),
                                _buildField(
                                  "Cidade",
                                  city,
                                  (v) => setState(() => city = v!),
                                ),
                                _buildField(
                                  "CEP",
                                  cep,
                                  (v) => setState(() => cep = v!),
                                  width: 150,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'CEP é obrigatório';
                                    }
                                    if (value.length < 8) {
                                      return 'CEP inválido';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            /// Botões de ação
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isEditing
                                          ? Colors.grey
                                          : AppColors.purple,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (isEditing) {
                                          // Cancelar edição - reverter alterações
                                          _formKey.currentState?.reset();
                                        }
                                        isEditing = !isEditing;
                                      });
                                    },
                                    child:
                                        Text(isEditing ? "Cancelar" : "Editar"),
                                  ),
                                  const SizedBox(width: 16),
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
                            ),

                            const SizedBox(height: 40),

                            /// Seção de segurança
                            Text("Segurança",
                                style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 16),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSecurityLink(
                                  "Política de Privacidade",
                                  () => context.go("/privacidade"),
                                ),
                                const SizedBox(height: 8),
                                _buildSecurityLink(
                                  "Alterar Senha",
                                  () => context.go("/alterar-senha"),
                                ),
                                const SizedBox(height: 8),
                                _buildSecurityLink(
                                  "Excluir conta",
                                  _showDeleteAccountDialog,
                                  isDestructive: true,
                                ),
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

          /// Footer
          const Footer(),
        ],
      ),
    );
  }

  Widget _buildField(
    String label,
    String value,
    Function(String?) onSaved, {
    double? width,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: width ?? 300,
      child: TextFormField(
        initialValue: value,
        enabled: isEditing,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: !isEditing,
          fillColor: !isEditing ? Colors.grey[100] : null,
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }

  //LINKS DE SEGURANÇA
  Widget _buildSecurityLink(
    String text,
    VoidCallback onPressed, {
    bool isDestructive = false,
  }) {
    final linkColor = isDestructive ? Colors.red : Color(0xFF629EA9);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: linkColor,
            decoration: TextDecoration.underline,
            decorationColor: linkColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Alterar foto"),
        content: const Text("Escolha uma opção:"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: implementar câmera
            },
            child: const Text("Câmera"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: implementar galeria
            },
            child: const Text("Galeria"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
        ],
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
