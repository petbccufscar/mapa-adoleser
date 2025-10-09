import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/presentation/ui/modal_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/carousel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_button.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatelessWidget {
  final String id;

  const ActivityPage({
    super.key,
    required this.id,
  });

  // helper para tags (chips coloridos sem ícone)
  Widget _tag(BuildContext context, String label, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  // helper para "instância" com bloco colorido à esquerda
  Widget _instanceCard(BuildContext context, String label, Color leftColor) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    return Container(
      constraints: const BoxConstraints(minWidth: 200),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6), // fundo claro do card
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // bloco colorido à esquerda
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: leftColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
          ),
          // texto
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(label,
                  style: textStyle?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // helper para card de avaliação
  Widget _reviewCard(
      BuildContext context, String nome, double rating, String texto) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(nome,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < rating.floor()
                        ? Icons.star
                        : (i < rating ? Icons.star_half : Icons.star_border),
                    color: Colors.amber,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            texto,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    const double averageRating = 4.3;
    const int totalRatings = 453;
    int filledStars = averageRating.floor();
    int emptyStars =
        5 - filledStars - (averageRating - filledStars > 0 ? 1 : 0);

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: auth.isLoggedIn),
      endDrawer: CustomDrawer(isLoggedIn: auth.isLoggedIn),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carrossel com imagens da atividade
            Carousel(),

            ResponsivePageWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 40,
                    runSpacing: 40,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // título e endereço
                          Text(
                            "Praça do Kartódromo",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "R. Dr. Donato dos Santos, 397 - Jardim Nova Santa Paula, São Carlos - SP, 13564-332",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),

                          const SizedBox(height: 16),

                          // tags
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: [
                              _tag(
                                context,
                                "Parque",
                                const Color(0xFFE6D57E),
                              ),
                              _tag(
                                context,
                                "Gratuito",
                                const Color(0xFFCFCFCF),
                              ),
                              _tag(
                                context,
                                "Exercícios",
                                const Color(0xFFFFB08A),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          CustomButton(
                            text: 'Adicionar aos favoritos',
                            onPressed: () {},
                          ),
                          CustomButton(
                            text: 'Compartilhar',
                            onPressed: () {},
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Descrição
                            Text(
                              "Descrição",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "O Parque do Kartódromo é um espaço de lazer e recreação ao ar livre, ideal para quem busca contato com a natureza e atividades esportivas. Com amplas áreas verdes, pistas para caminhadas e ciclismo, playgrounds e espaços para piqueniques, o parque se tornou um ponto de encontro para famílias, atletas e amantes do ar livre. Seu nome faz referência ao kartódromo localizado nas proximidades, que atrai entusiastas da velocidade. Além disso, o local conta com infraestrutura para eventos, quadras esportivas e um ambiente agradável para descanso e convivência.",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                            ),

                            const SizedBox(height: 40),

                            // Instâncias envolvidas
                            Text(
                              "Instâncias Envolvidas",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),

                            const SizedBox(height: 16),

                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _instanceCard(
                                    context,
                                    "Prefeitura de São Carlos",
                                    const Color(0xFFF79F9F)),
                                _instanceCard(
                                    context,
                                    "Coletivo de Esportes de São Carlos",
                                    const Color(0xFF7BE07B)),
                              ],
                            ),
                            const SizedBox(height: 40),

                            // Avaliações
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // alinhado à esquerda
                                  children: [
                                    Text(
                                      "Avaliações",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    CustomButton(
                                      text: 'Adicionar avaliação',
                                      icon: Icons.add,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    ...List.generate(
                                        filledStars,
                                        (idx) => const Icon(Icons.star,
                                            color: Colors.amber, size: 20)),
                                    if (averageRating - filledStars > 0)
                                      const Icon(Icons.star_half,
                                          color: Colors.amber, size: 20),
                                    ...List.generate(
                                        emptyStars,
                                        (idx) => const Icon(Icons.star_border,
                                            color: Colors.amber, size: 20)),
                                    const SizedBox(width: 12),
                                    Text(
                                        "Quantidade: $totalRatings avaliações   Média: $averageRating"),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),

                            // cards de avaliações
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _reviewCard(context, "Vinicius", 5,
                                      "Texto Texto Texto Texto Texto Texto"),
                                  const SizedBox(width: 16),
                                  _reviewCard(context, "Maria", 4,
                                      "Texto Texto Texto Texto Texto Texto"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Atividades similares
                            Text("Atividades similares",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            ModalWrapper(
                              child: Column(
                                children: [
                                  Text(
                                    "Informações Rápidas",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Horário',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '6h às 22h - Todos os dias',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Faixa Etária',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Todas as idades',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Acessibilidade',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Acessível para cadeirantes',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            ),
                            ModalWrapper(
                              child: Column(
                                children: [
                                  Text(
                                    "Contato",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                            ),
                            ModalWrapper(
                              child: Column(
                                children: [
                                  Text(
                                    "Localização",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
