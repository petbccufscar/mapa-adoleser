import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

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
              child: Column(
                spacing: 35,
                children: [
                  Text(
                    'Sobre o Mapa Adoleser',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'O AdoleSer é um núcleo pensado para o cuidado integral de adolescentes e suas famílias, composto por uma médica hebiatra, uma psiquiatra, 1 professora de enfermagem e 1 professora de terapia ocupacional da Universidade Federal de São Carlos.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    'Entre suas ações, está a discussão de assuntos relacionados a adolescência, o apoio a rede para os atendimentos e a participação e coordenação do grupo Juntos pelas Adolescências, um grupo intersetorial que tem por objetivo discutir casos complexos, fornecer suporte em rede e pensar em propostas de melhoria para a população adolescente de São Carlos.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                  Image.asset('assets/images/megafonetexto.png', scale: 1.2)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
