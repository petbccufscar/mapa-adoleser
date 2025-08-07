import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AvaliacaoDialog extends StatefulWidget {
  const AvaliacaoDialog({super.key});

  @override
  State<AvaliacaoDialog> createState() => _AvaliacaoDialogState();
}

class _AvaliacaoDialogState extends State<AvaliacaoDialog> {
  double _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Deixe sua avaliação"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // <- Alinha à esquerda
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _currentRating = rating;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Escreva seu comentário (opcional)',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Enviar'),
          onPressed: () {
            // Aqui você pode usar _currentRating e o conteúdo do TextField
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
