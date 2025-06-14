import 'package:flutter/material.dart';

class FaixaEtariaSelector extends StatefulWidget {
  const FaixaEtariaSelector({super.key});

  @override
  State<FaixaEtariaSelector> createState() => _FaixaEtariaSelectorState();
}

class _FaixaEtariaSelectorState extends State<FaixaEtariaSelector> {
  final TextEditingController _idadeMinimaController = TextEditingController();
  final TextEditingController _idadeMaximaController = TextEditingController();

  void _aplicarFiltro() {
    final String idadeMinima = _idadeMinimaController.text;
    final String idadeMaxima = _idadeMaximaController.text;

    if (idadeMinima.isEmpty || idadeMaxima.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha os dois campos de idade.')),
      );
      return;
    }

    int min = int.parse(idadeMinima);
    int max = int.parse(idadeMaxima);

    if (min > max) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A idade mínima deve ser menor que a máxima.')),
      );
      return;
    }

    // Aqui você faz a lógica de filtragem ou passa esses valores para outro widget ou provider
    print('Filtrar locais entre $min e $max anos');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Faixa etária',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _idadeMinimaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'De',
                    hintText: 'Idade',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _idadeMaximaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Até',
                    hintText: 'Idade',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _aplicarFiltro,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Filtrar locais',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
