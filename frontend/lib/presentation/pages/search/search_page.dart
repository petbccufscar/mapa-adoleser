import 'package:flutter/material.dart';
import 'package:mapa_adoleser/presentation/widgets/app_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text(
          'Busca!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
