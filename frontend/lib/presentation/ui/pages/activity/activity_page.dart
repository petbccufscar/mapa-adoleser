import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/core/utils/colors_utils.dart';
import 'package:mapa_adoleser/domain/models/activity_model.dart';
import 'package:mapa_adoleser/domain/models/category_model.dart';
import 'package:mapa_adoleser/domain/models/instance_activity_model.dart';
import 'package:mapa_adoleser/domain/models/related_activity_model.dart';
import 'package:mapa_adoleser/domain/models/review_model.dart';
import 'package:mapa_adoleser/presentation/ui/responsive_page_wrapper.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/carousel.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/horizontal_arrow_list.dart';
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
        style: Theme.of(context).textTheme.titleMedium,
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
    return Material(
      color: AppColors.backgroundWhite,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.go('/instanscia/${instance.id}');
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.border,
              width: 1,
            ),
          ),
          child: Text(
            instance.name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

class _RelatedActivityCard extends StatelessWidget {
  final RelatedActivityModel activity;

  const _RelatedActivityCard({
    required this.activity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.backgroundWhite,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          context.go('/atividade/${activity.id}');
        },
        child: Container(
          height: double.infinity,
          width: 220,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                activity.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                  const SizedBox(width: 2),
                  Text(
                    "${activity.averageRating} - (${activity.ratingCount} avaliações)",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
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
      width: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite, // fundo claro do card
        borderRadius: BorderRadius.circular(10),
        border: BoxBorder.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                review.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 10),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < review.rating.floor()
                        ? Icons.star_rounded
                        : (i < review.rating
                            ? Icons.star_half_rounded
                            : Icons.star_border_rounded),
                    color: Colors.amber,
                    size: 18,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  textAlign: TextAlign.end,
                  'Há 2 dias',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review.comment,
            maxLines: 3,
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

  double calculateAverageRating(List<ReviewModel> reviews) {
    if (reviews.isEmpty) return 0;

    final total = reviews.fold<double>(
      0,
      (sum, review) => sum + review.rating,
    );

    return total / reviews.length;
  }

  List<Widget> buildStars(double average) {
    const totalStars = 5;

    final fullStars = average.floor();
    final decimal = average - fullStars;

    final hasHalfStar = decimal >= 0.25 && decimal < 0.75;
    final extraFullStar = decimal >= 0.75 ? 1 : 0;

    final filledStars = fullStars + extraFullStar;
    final emptyStars = totalStars - filledStars - (hasHalfStar ? 1 : 0);

    return [
      // estrelas cheias
      ...List.generate(
        filledStars,
        (_) => const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
      ),

      // meia estrela
      if (hasHalfStar)
        const Icon(Icons.star_half_rounded, color: Colors.amber, size: 18),

      // estrelas vazias
      ...List.generate(
        emptyStars,
        (_) => const Icon(Icons.star_border_rounded,
            color: Colors.amber, size: 18),
      ),
    ];
  }

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
            SelectableText(
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
            if (activity != null)
              HorizontalArrowList(
                height: 60,
                itemCount: activity!.instances.length,
                itemBuilder: (context, index) {
                  return _InstanceCard(
                    instance: activity!.instances[index],
                    key: ValueKey(activity!.instances[index].id),
                  );
                },
              )
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
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Média: ${calculateAverageRating(activity!.reviews).toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 12),
                Text(
                  'Quantidade: ${activity!.reviews.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (activity != null)
              HorizontalArrowList(
                height: 135,
                itemCount: activity!.reviews.length,
                itemBuilder: (context, index) {
                  return _ReviewCard(
                    review: activity!.reviews[index],
                    key: ValueKey(activity!.reviews[index].id),
                  );
                },
              )
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
            if (activity != null)
              HorizontalArrowList(
                height: 250,
                itemCount: activity!.related.length,
                itemBuilder: (context, index) {
                  return _RelatedActivityCard(
                    activity: activity!.related[index],
                    key: ValueKey(activity!.related[index].id),
                  );
                },
              )
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
            SelectableText(
              activity?.operatingHours.displayText ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Faixa Etária',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            SelectableText(
              activity?.ageRange.displayText ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Acessibilidade',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            SelectableText(
              activity?.accessibility ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Contato',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            SelectableText(
              activity?.contact ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
            )
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
      body: CustomScrollView(
        slivers: [
          // Carrossel com imagens da atividade
          SliverToBoxAdapter(
            child: Carousel(),
          ),

          SliverToBoxAdapter(
            child: ResponsivePageWrapper(
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
                          SelectableText(
                            activityProvider.activity?.name ??
                                'Nome da Atividade',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),

                          const SizedBox(height: 10),

                          SelectableText(
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
          ),
        ],
      ),
    );
  }
}
