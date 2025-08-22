import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
        child: SizedBox(
          width: 900, // Limita a largura do texto a no máximo 600 pixels
          child: Padding(
            padding: EdgeInsets.all(16.0), // Espaço interno para melhorar a leitura
            child: 
            Column(
              children: [
                SizedBox(height : 100),
                Text(
                  'O AdoleSer é um núcleo pensado para o cuidado integral de adolescentes e suas famílias, composto por uma médica hebiatra, uma psiquiatra, 1 professora de enfermagem e 1 professora de terapia ocupacional da Universidade Federal de São Carlos.',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height : 60),
                Text(
                  'Entre suas ações, está a discussão de assuntos relacionados a adolescência, o apoio a rede para os atendimentos e a participação e coordenação do grupo Juntos pelas Adolescências, um grupo intersetorial que tem por objetivo discutir casos complexos, fornecer suporte em rede e pensar em propostas de melhoria para a população adolescente de São Carlos.',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height : 40),
                Image.asset('assets/images/megafonetexto.png',
                scale: 1)
              ],
            )
          ),
        ),
      ),
    );
  }
}
