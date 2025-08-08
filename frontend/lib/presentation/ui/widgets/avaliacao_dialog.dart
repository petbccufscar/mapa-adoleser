import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';

class AvaliacaoDialog extends StatefulWidget {
  const AvaliacaoDialog({super.key});

  @override
  State<AvaliacaoDialog> createState() => _AvaliacaoDialogState();
}

class _AvaliacaoDialogState extends State<AvaliacaoDialog> {
  double _currentRating = 0; // Já começa com 1 estrela
  final TextEditingController _commentController = TextEditingController();
  String? _errorMessage; // Para exibir o erro dentro do popup

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_currentRating < 1) {
      setState(() {
        _errorMessage = 'Você deve selecionar pelo menos 1 estrela.';
      });
      return;
    }

    final comment = _commentController.text.trim();

    print('Nota: $_currentRating');
    print('Comentário: ${comment.isNotEmpty ? comment : "Sem comentário"}');

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Deixe sua avaliação"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Nota:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                RatingBar.builder(
                  initialRating: _currentRating,
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
                      _errorMessage = null; // Limpa erro se usuário alterar
                    });
                  },
                ),
              ],
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 4),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _commentController,
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
        CustomButton(
          text: 'Cancelar',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CustomButton(
          text: 'Enviar',
          onPressed: _submit,
        ),
      ],
    );
  }
}
