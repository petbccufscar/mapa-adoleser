import 'package:flutter/material.dart';
import 'package:mapa_adoleser/domain/models/category_model.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_dropdown_field.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mapa_adoleser/providers/category_provider.dart';
import 'package:provider/provider.dart';

class MapFilters extends StatefulWidget {
  const MapFilters({super.key});

  @override
  State<MapFilters> createState() => _MapFiltersState();
}

class _MapFiltersState extends State<MapFilters> {
  final _cepController = TextEditingController();

  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();

    final List<CategoryModel> categoriesList = categoryProvider.categories;

    return Wrap(
      spacing: 8, // espaçamento horizontal entre itens
      runSpacing: 4, // espaçamento vertical entre linhas
      children: [
        CustomTextField(
          label: 'CEP',
          hint: 'Digite seu CEP',
          controller: _cepController,
        ),
        CustomTextField(
          label: 'Endereço',
          hint: 'Digite seu endereço',
          controller: _cepController,
        ),
        CustomDropdownField<CategoryModel>(
          label: 'Categoria',
          hint: 'Categoria',
          value: selectedCategory,
          items: categoriesList,
          onChanged: (CategoryModel? value) => {
            setState(() {
              selectedCategory = value;
            })
          },
          getLabel: (item) => item.name,
        ),
        const Chip(label: Text('Item 2')),
        const Chip(label: Text('Item 3')),
        const Chip(label: Text('Item 4')),
        const Chip(label: Text('Item 4')),
        const Chip(label: Text('Item 4')),
        const Chip(label: Text('Item 4')),
        const Chip(label: Text('Item 5')),
      ],
    );
  }
}
