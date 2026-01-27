import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/responses/review_response_model.dart';

class ReviewService {
  Future<List<ReviewResponseModel>> getReviewsByActivityId(String id) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da atividade não pode ser vazio');
    }

    if (id == "UUID_INVALIDO") {
      throw FetchDataException('Atividade não encontrada');
    }

    final List<ReviewResponseModel> reviews = <ReviewResponseModel>[
      ReviewResponseModel(
        id: "1",
        name: "Vinicius",
        comment: "Gostei muito!",
        rating: 5,
        date: DateTime.now(),
      ),
      ReviewResponseModel(
        id: "2",
        name: "Julio",
        comment: "Não gostei",
        rating: 2.5,
        date: DateTime.now(),
      ),
    ];

    return reviews;
  }

  Future<List<ReviewResponseModel>> getReviewsByInstanceId(String id) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da instância não pode ser vazio');
    }

    if (id == "UUID_INVALIDO") {
      throw FetchDataException('Instância não encontrada');
    }

    final List<ReviewResponseModel> reviews = <ReviewResponseModel>[
      ReviewResponseModel(
        id: "1",
        name: "Vinicius",
        comment: "Gostei mais ou menos",
        rating: 3.5,
        date: DateTime.now(),
      ),
      ReviewResponseModel(
        id: "2",
        name: "Julio",
        comment: "Até que gostei",
        rating: 4,
        date: DateTime.now(),
      ),
    ];

    return reviews;
  }
}
