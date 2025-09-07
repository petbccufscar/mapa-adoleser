// providers/contact_provider.dart
import 'package:flutter/cupertino.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/category_service.dart';
import 'package:mapa_adoleser/domain/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();

  String? _error;
  bool _loading = false;
  final bool _success = false;
  List<CategoryModel> _categories = [];

  CategoryProvider() {
    getCategories();
  }

  bool get isLoading => _loading;
  String? get error => _error;
  bool get success => _success;
  List<CategoryModel> get categories => _categories;

  Future<void> getCategories() async {
    if (categories.isNotEmpty) return;

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _categories = await _categoryService.fetchCategories();
    } catch (e) {
      _error = parseException(e);
      _categories = [];
    }

    _loading = false;
    notifyListeners();
  }
}
