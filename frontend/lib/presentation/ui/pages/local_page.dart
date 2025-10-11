import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/carousel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ActivityDetailPage extends StatelessWidget {
  const ActivityDetailPage({super.key});

  // helper para tags (chips coloridos sem ícone)
  Widget _tag(BuildContext context, String label, Color bgColor,
      {Color? borderColor}) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      child: Text(label, style: textStyle),
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
    final isLoggedIn = auth.isLoggedIn;

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1000;

    const double averageRating = 4.3;
    const int totalRatings = 453;
    int filledStars = averageRating.floor();
    int emptyStars =
        5 - filledStars - (averageRating - filledStars > 0 ? 1 : 0);

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: isLoggedIn)
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // carousel
            Carousel(),

            ResponsivePageWrapper(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // título e endereço
                    Text(
                      "Praça do Kartódromo",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "R. Dr. Donato dos Santos, 397 - Jardim Nova Santa Paula, São Carlos - SP, 13564-332",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 18),

                    // tags
                    Wrap(
                      spacing: 6,
                      runSpacing: 8,
                      children: [
                        _tag(context, "Parque", const Color(0xFFE6D57E)),
                        _tag(context, "Gratuito", const Color(0xFFCFCFCF)),
                        _tag(context, "Infantil", const Color(0xFFF9C7F3)),
                        _tag(context, "Exercícios", const Color(0xFFFFB08A)),
                        _tag(context, "Adulto", const Color(0xFFFF59C3)),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Descrição
                    Text("Descrição",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                      "O Parque do Kartódromo é um espaço de lazer e recreação ao ar livre, ideal para quem busca contato com a natureza e atividades esportivas. Com amplas áreas verdes, pistas para caminhadas e ciclismo, playgrounds e espaços para piqueniques, o parque se tornou um ponto de encontro para famílias, atletas e amantes do ar livre. Seu nome faz referência ao kartódromo localizado nas proximidades, que atrai entusiastas da velocidade. Além disso, o local conta com infraestrutura para eventos, quadras esportivas e um ambiente agradável para descanso e convivência.",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),

                    // Instâncias envolvidas
                    Text("Instâncias Envolvidas",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    isDesktop
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _instanceCard(
                                  context,
                                  "Prefeitura de São Carlos",
                                  const Color(0xFFF79F9F),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _instanceCard(
                                  context,
                                  "Coletivo de Esportes de São Carlos",
                                  const Color(0xFF7BE07B),
                                ),
                              ),
                            ],
                          )
                        : Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              SizedBox(
                                  width: screenWidth * 0.9,
                                  child: _instanceCard(
                                      context,
                                      "Prefeitura de São Carlos",
                                      const Color(0xFFF79F9F))),
                              SizedBox(
                                  width: screenWidth * 0.9,
                                  child: _instanceCard(
                                      context,
                                      "Coletivo de Esportes de São Carlos",
                                      const Color(0xFF7BE07B))),
                            ],
                          ),
                    const SizedBox(height: 24),

                    // Avaliações
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.start, // alinhado à esquerda
                          children: [
                            Text(
                              "Avaliações",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                                width: 16), // espaço entre título e botão
                            FilledButton.icon(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFFAEE3C9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                elevation: 0,
                              ),
                              icon: const Icon(Icons.add_circle,
                                  size: 20, color: Colors.black),
                              label: const Text(
                                "Fazer uma avaliação",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
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
            ),
          ],
        ),
      ),
    );
  }
}
