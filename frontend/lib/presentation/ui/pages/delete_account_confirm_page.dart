import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountConfirmPage extends StatelessWidget {
  const DeleteAccountConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Excluir conta",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E1B47),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Deseja excluir sua conta? Seus dados não serão salvos e não será possível recuperá-la.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4C5466), // subtítulo
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Botão "Sim"
              SizedBox(
                width: 372,
                child: ElevatedButton(
                  onPressed: () => context.go("/excluir-sucesso"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAEE3C9), // verde claro
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Sim",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Botão "Cancelar"
              SizedBox(
                width: 372,
                child: ElevatedButton(
                  onPressed: () => context.go("/perfil"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5A5A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Cancelar",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
