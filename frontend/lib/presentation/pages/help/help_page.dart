import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Ajuda!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
