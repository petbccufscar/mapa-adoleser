import 'package:flutter/material.dart';
import 'package:mapa_adoleser/presentation/widgets/app_bar.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text(
          'Ajuda!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
