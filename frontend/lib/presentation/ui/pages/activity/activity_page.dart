import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/presentation/ui/modal_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/carousel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/activity_provider.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ActivityPage extends StatefulWidget {
  final String id;

  const ActivityPage({
    required this.id,
    super.key,
  });

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
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

  // helper para "instância"
  Widget _instanceCard(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite, // fundo claro do card
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(color: AppColors.border, width: 1),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  // helper para card de avaliação
  Widget _reviewCard(
      BuildContext context, String nome, double rating, String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite, // fundo claro do card
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(nome, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(width: 8),
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
              const SizedBox(width: 8),
              Text(
                '${rating.toStringAsFixed(1)} / 5',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: 8),
              Text(
                'Há 2 dias',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            texto,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget rightColumnContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ModalWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Informações Rápidas",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              Text(
                'Horário',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 5),
              Text(
                '6h às 22h - Todos os dias',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.textTertiary),
              ),
              const SizedBox(height: 20),
              Text(
                'Faixa Etária',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 5),
              Text(
                'Todas as idades',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.textTertiary),
              ),
              const SizedBox(height: 20),
              Text(
                'Acessibilidade',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 5),
              Text(
                'Acessível para cadeirantes',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.textTertiary),
              )
            ],
          ),
        ),
        const SizedBox(height: 12),
        ModalWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Contato",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {},
                child: Text('(16) 3854-1966'),
              ),
              const SizedBox(height: 5),
              FilledButton(
                child: Text('Site oficial'),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ModalWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Localização",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              FilledButton(child: Text('Ver no mapa'), onPressed: () {})
            ],
          ),
        )
      ],
    );
  }

  Widget leftColumnContent(BuildContext context) {
    const double averageRating = 4.3;
    const int totalRatings = 453;
    int filledStars = averageRating.floor();
    int emptyStars =
        5 - filledStars - (averageRating - filledStars > 0 ? 1 : 0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
            _instanceCard(context, "Prefeitura de São Carlos"),
            _instanceCard(context, "Coletivo de Esportes de São Carlos"),
          ],
        ),

        const SizedBox(height: 40),

        // Avaliações
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // alinhado à esquerda
              children: [
                Text(
                  "Avaliações",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                FilledButton.icon(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  label: Text('Adicionar avaliação'),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ...List.generate(
                    filledStars,
                    (idx) =>
                        const Icon(Icons.star, color: Colors.amber, size: 20)),
                if (averageRating - filledStars > 0)
                  const Icon(Icons.star_half, color: Colors.amber, size: 20),
                ...List.generate(
                    emptyStars,
                    (idx) => const Icon(Icons.star_border,
                        color: Colors.amber, size: 20)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                      "Quantidade: $totalRatings avaliações   Média: $averageRating"),
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),

        // cards de avaliações
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              _reviewCard(context, "Vinicius", 5,
                  "Texto Texto Texto Texto Texto Texto"),
              const SizedBox(width: 16),
              _reviewCard(
                  context, "Maria", 4, "Texto Texto Texto Texto Texto Texto"),
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
    );
  }

  @override
  void initState() {
    super.initState();

    context.read<ActivityProvider>().getActivityById(widget.id);
  }

  @override
  void didUpdateWidget(covariant ActivityPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    // se o :id mudar sem desmontar a página, recarrega
    if (oldWidget.id != widget.id) {
      context.read<ActivityProvider>().getActivityById(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final activityProvider = context.watch<ActivityProvider>();

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
                            activityProvider.activity?.name ??
                                'Nome da Atividade',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
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
                          FilledButton.icon(
                            onPressed: () {},
                            label: Text('Favoritar'),
                            icon: Icon(Icons.favorite_rounded),
                          ),
                          FilledButton.icon(
                            onPressed: () {},
                            label: Text('Compartilhar'),
                            icon: Icon(Icons.share_rounded),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  if (ResponsiveBreakpoints.of(context)
                      .largerOrEqualTo('LARGE_TABLET'))
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: leftColumnContent(context),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 1,
                          child: rightColumnContent(context),
                        )
                      ],
                    )
                  else
                    Column(
                      children: [
                        leftColumnContent(context),
                        const SizedBox(height: 40),
                        rightColumnContent(context)
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
