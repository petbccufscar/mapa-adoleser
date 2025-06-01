import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/responsive_menu.dart';
import '../../widgets/text_field.dart';
import '../../widgets/carrossel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final menuItems = ['sobre', 'pesquisa'];

    return Scaffold(
      appBar: ResponsiveMenu(menuItems: menuItems),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carrossel no topo
            const Carrossel(),

            const SizedBox(height: 20),

            Text(
              'Home!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            CustomTextField(
              label: "Nome",
              hint: "Digite seu email",
              controller: controller,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Campo obrigatório";
                }
                if (!value.contains("@")) {
                  return "Email inválido";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
