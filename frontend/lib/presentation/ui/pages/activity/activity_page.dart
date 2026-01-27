import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/colors_utils.dart';
import 'package:mapa_adoleser/domain/models/activity_model.dart';
import 'package:mapa_adoleser/domain/models/category_model.dart';
import 'package:mapa_adoleser/domain/models/instance_activity_model.dart';
import 'package:mapa_adoleser/domain/models/review_model.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/carousel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/activity_provider.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web/web.dart' as web;

class ActivityPage extends StatefulWidget {
  final String id;

  const ActivityPage({
    required this.id,
    super.key,
  });

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _CategoryChip extends StatelessWidget {
  final CategoryModel category;

  const _CategoryChip({
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: ColorsUtils.categoryColor(category.id),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        category.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _InstanceCard extends StatelessWidget {
  final InstanceActivityModel instance;

  const _InstanceCard({
    required this.instance,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite, // fundo claro do card
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(color: AppColors.border, width: 1),
      ),
      child: Text(
        instance.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const _ReviewCard({
    required this.review,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              Text(review.name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(width: 8),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < review.rating.floor()
                        ? Icons.star
                        : (i < review.rating
                            ? Icons.star_half
                            : Icons.star_border),
                    color: Colors.amber,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${review.rating.toStringAsFixed(1)} / 5',
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
            review.comment,
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
}

class _MainColumn extends StatelessWidget {
  final ActivityModel? activity;

  const _MainColumn({
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Descrição
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Descrição",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              activity?.description ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ],
        ),

        const SizedBox(height: 30),

        // Instâncias envolvidas
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Instâncias Envolvidas",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: activity?.instances.map(
                    (instance) {
                      return _InstanceCard(
                        key: ValueKey(instance.id),
                        instance: instance,
                      );
                    },
                  ).toList() ??
                  [],
            ),
          ],
        ),

        const SizedBox(height: 30),

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
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                FilledButton.icon(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  label: Text('Adicionar avaliação'),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ...List.generate(
                    5,
                    (idx) =>
                        const Icon(Icons.star, color: Colors.amber, size: 20)),
                if (5 - 1 > 0)
                  const Icon(Icons.star_half, color: Colors.amber, size: 20),
                ...List.generate(
                    0,
                    (idx) => const Icon(Icons.star_border,
                        color: Colors.amber, size: 20)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text("Quantidade: 5 avaliações Média: 58"),
                )
              ],
            ),
            const SizedBox(height: 20),

            // cards de avaliações
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: activity?.reviews.map(
                    (review) {
                      return _ReviewCard(
                        key: ValueKey(review.id),
                        review: review,
                      );
                    },
                  ).toList() ??
                  [],
            ),
          ],
        ),

        const SizedBox(height: 30),

        // Atividades similares
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Atividades similares",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: activity?.related.map(
                    (realted) {
                      return Text(
                        realted.name,
                      );
                    },
                  ).toList() ??
                  [],
            ),
          ],
        )
      ],
    );
  }
}

class _SideColumn extends StatelessWidget {
  final ActivityModel? activity;

  const _SideColumn({
    required this.activity,
  });

  void openGoogleMaps(String address) {
    final encoded = Uri.encodeComponent(address);
    final url = 'https://www.google.com/maps/search/?api=1&query=$encoded';

    web.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informações Rápidas",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              'Horário',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            Text(
              activity?.operatingHours.displayText ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Faixa Etária',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            Text(
              activity?.ageRange.displayText ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Acessibilidade',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            Text(
              activity?.accessibility ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Contato",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: activity == null ? null : () {},
              child: Text(
                activity?.phone ?? "-",
              ),
            ),
            const SizedBox(height: 5),
            FilledButton(
              onPressed: activity == null ? null : () {},
              child: Text(
                activity?.website ?? "-",
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Localização",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 15),
            FilledButton(
              onPressed: activity?.address == null
                  ? null
                  : () => openGoogleMaps(activity!.address),
              child: Text('Ver no mapa'),
            )
          ],
        ),
      ],
    );
  }
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<ActivityProvider>().getActivityById(widget.id);
    });
  }

  // @override
  // void didUpdateWidget(covariant ActivityPage oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   // se o :id mudar sem desmontar a página, recarrega
  //   if (oldWidget.id != widget.id) {
  //     context.read<ActivityProvider>().getActivityById(widget.id);
  //   }
  // }

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
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            activityProvider.activity?.address ??
                                'Endereço da Atividade',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),

                          const SizedBox(height: 20),

                          // tags
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: activityProvider.activity?.categories.map(
                                  (category) {
                                    return _CategoryChip(
                                      key: ValueKey(category.id),
                                      category: category,
                                    );
                                  },
                                ).toList() ??
                                [],
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _MainColumn(
                            activity: activityProvider.activity,
                          ),
                        ),
                        const SizedBox(width: 60),
                        // largura fixa
                        SizedBox(
                          width: 320,
                          child: _SideColumn(
                            activity: activityProvider.activity,
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SideColumn(
                          activity: activityProvider.activity,
                        ),
                        const SizedBox(height: 30),
                        _MainColumn(
                          activity: activityProvider.activity,
                        ),
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
