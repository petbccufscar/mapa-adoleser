import 'package:mapa_adoleser/domain/models/category_model.dart';

class CategoryService {
  Future<List<CategoryModel>> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 2));

    final List<CategoryModel> categoryList = <CategoryModel>[
      CategoryModel(id: 1, name: 'Esporte'),
      CategoryModel(id: 2, name: 'Praças'),
      CategoryModel(id: 3, name: 'Conversação')
    ];

    return categoryList;
  }
}
