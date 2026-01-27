import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/responses/category_response_model.dart';

class CategoryService {
  Future<List<CategoryResponseModel>> getCategoriesByActivityId(
      String id) async {
    await Future.delayed(const Duration(seconds: 2));

    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da instância não pode ser vazio');
    }

    if (id == "UUID_INVALIDO") {
      throw FetchDataException('Instância não encontrada');
    }

    final List<CategoryResponseModel> categoriesList = <CategoryResponseModel>[
      CategoryResponseModel(
        id: "1",
        name: "Parque",
      ),
      CategoryResponseModel(
        id: "2",
        name: "Gratuito",
      ),
      CategoryResponseModel(
        id: "3",
        name: "Infantil",
      ),
      CategoryResponseModel(
        id: "4",
        name: "Exercício",
      ),
    ];

    return categoriesList;
  }

  Future<List<CategoryResponseModel>> getCategoriesByInstanceId(
      String id) async {
    await Future.delayed(const Duration(seconds: 2));

    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da instância não pode ser vazio');
    }

    if (id == "UUID_INVALIDO") {
      throw FetchDataException('Instância não encontrada');
    }

    final List<CategoryResponseModel> categoriesList = <CategoryResponseModel>[
      CategoryResponseModel(
        id: "1",
        name: "Parque",
      ),
      CategoryResponseModel(
        id: "2",
        name: "Gratuito",
      ),
      CategoryResponseModel(
        id: "3",
        name: "Infantil",
      ),
      CategoryResponseModel(
        id: "4",
        name: "Exercício",
      ),
    ];

    return categoriesList;
  }
}
