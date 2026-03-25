import 'package:flutter/material.dart';
import 'package:mapa_adoleser/providers/activity_search_provider.dart';
import 'package:provider/provider.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class SearchPanelWidget extends StatefulWidget {
  final ScrollController? scrollController;
  
  const SearchPanelWidget({super.key, this.scrollController});

  @override
  State<SearchPanelWidget> createState() => _SearchPanelWidgetState();
}

class _SearchPanelWidgetState extends State<SearchPanelWidget> {
  final _searchController = TextEditingController();
  final _cepController = TextEditingController();
  final _targetAgeController = TextEditingController();
  String? _selectedCategory;
  String? _selectedPeriod;

  @override
  void dispose() {
    _searchController.dispose();
    _cepController.dispose();
    _targetAgeController.dispose();
    super.dispose();
  }

  void _applyFilters(BuildContext context) {
    final provider = context.read<ActivitySearchProvider>();
    provider.setFilters(
      search: _searchController.text,
      cep: _cepController.text,
      targetAge: _targetAgeController.text,
      category: _selectedCategory ?? '',
      period: _selectedPeriod ?? '',
    );
    provider.searchActivities();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActivitySearchProvider>();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(-2, 0),
          )
        ]
      ),
      child: Column(
        children: [
          _buildFilterSection(context),
          const Divider(height: 1, color: AppColors.border),
          Expanded(
            child: _buildResultsList(provider),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    final categories = ['Esportes', 'Cultura', 'Lazer', 'Educação', 'Música', 'Artes'];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _searchController,
            onSubmitted: (_) => _applyFilters(context),
            decoration: InputDecoration(
              hintText: 'Buscar atividades...',
              prefixIcon: const Icon(Icons.search, color: AppColors.purple),
              filled: true,
              fillColor: AppColors.backgroundWhite,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Categories Chips
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = _selectedCategory == cat;
                return FilterChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => _selectedCategory = selected ? cat : null);
                    _applyFilters(context);
                  },
                  backgroundColor: AppColors.backgroundSmoke,
                  selectedColor: AppColors.tealLight,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  side: BorderSide.none,
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          // Advanced Filters
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: const Text('Filtros Avançados', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.purple)),
              childrenPadding: const EdgeInsets.only(bottom: 12),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _cepController,
                        decoration: const InputDecoration(labelText: 'CEP'),
                        onSubmitted: (_) => _applyFilters(context),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _targetAgeController,
                        decoration: const InputDecoration(labelText: 'Idade alvo'),
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => _applyFilters(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Período do Dia'),
                  value: _selectedPeriod,
                  items: ['Manhã', 'Tarde', 'Noite']
                      .map((p) => DropdownMenuItem(value: p.toLowerCase(), child: Text(p)))
                      .toList(),
                  onChanged: (val) {
                    setState(() => _selectedPeriod = val);
                    _applyFilters(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(ActivitySearchProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.pink));
    }

    if (provider.error != null) {
      return Center(child: Text('Erro: ${provider.error}', style: const TextStyle(color: AppColors.warning)));
    }

    if (provider.activities.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 64, color: AppColors.inputPlaceholder),
            SizedBox(height: 16),
            Text('Nenhuma atividade encontrada', style: TextStyle(color: AppColors.textSecondary)),
          ],
        )
      );
    }

    return ListView.separated(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: provider.activities.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final activity = provider.activities[index];
        final isSelected = provider.selectedActivity?.id == activity.id;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.pink : AppColors.border,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: AppColors.pink.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ] : [],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => provider.selectActivity(activity),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundSoft.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.local_activity_rounded, color: AppColors.backgroundSoft),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              activity.instanceName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, size: 16, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          activity.instanceAddress,
                          style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (activity.ageRange.start > 0) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.purpleLight.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Idade Alvo: ${activity.ageRange.start} anos',
                        style: const TextStyle(fontSize: 12, color: AppColors.purple, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                  if (isSelected) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                           context.push('/atividade/${activity.id}');
                        },
                        icon: const Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.white),
                        label: const Text('Ver Detalhes da Atividade', style: TextStyle(color: Colors.white)),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.pink,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
