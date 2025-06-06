import 'package:flutter/material.dart';
import 'package:mapa_adoleser/presentation/widgets/app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text(
          'Sobre!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
