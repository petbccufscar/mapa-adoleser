import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountCodePage extends StatefulWidget {
  const DeleteAccountCodePage({super.key});

  @override
  State<DeleteAccountCodePage> createState() => _DeleteAccountCodePageState();
}

class _DeleteAccountCodePageState extends State<DeleteAccountCodePage> {
  // Controllers para cada campo de dígito
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  // FocusNodes para avançar o cursor automaticamente
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  // Timer do botão "Reenviar"
  int _seconds = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer(); // inicia contagem regressiva
  }

  // Lógica do contador
  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_seconds > 1) {
        setState(() => _seconds--);
        return true; // continua
      } else {
        setState(() => _canResend = true);
        return false; // para
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Medidas fixas para caixas e botões
    const int boxWidth = 50;
    const int spacing = 8;
    const int totalBoxes = 6;
    const double totalWidth =
        (boxWidth * totalBoxes) + (spacing * (totalBoxes - 1));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Excluir conta",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            const Text("Digite o código recebido"),
            const SizedBox(height: 20),

            //  Campos individuais para o código
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalBoxes, (index) {
                return Container(
                  width: boxWidth.toDouble(),
                  margin: EdgeInsets.symmetric(horizontal: spacing / 2),
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    onChanged: (value) {
                      // avança o foco automaticamente
                      if (value.isNotEmpty && index < totalBoxes - 1) {
                        FocusScope.of(context)
                            .requestFocus(_focusNodes[index + 1]);
                      }
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Botão Reenviar (fica desabilitado até o timer acabar)
            SizedBox(
              width: totalWidth,
              child: ElevatedButton(
                onPressed: _canResend ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF629EA9),
                  disabledBackgroundColor: const Color(0xFF629EA9),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _canResend ? "Reenviar" : "Reenviar (${_seconds}s)",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Botão Validar
            SizedBox(
              width: totalWidth,
              child: ElevatedButton(
                onPressed: () => context.go("/excluir-confirmar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C5AA6),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Validar",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
