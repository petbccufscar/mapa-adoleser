import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/responses/review_response_model.dart';

class ReviewService {
  Future<List<ReviewResponseModel>> getReviewsByActivityId(String id) async {
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
        comment:
            "Gostei muito da atividade. O espaço é bem organizado, os profissionais são atenciosos e a proposta realmente cumpre o que promete. Voltaria com certeza.",
        rating: 5,
        date: DateTime.now(),
      ),
      ReviewResponseModel(
        id: "2",
        name: "Julio",
        comment:
            "A experiência não foi muito boa. Achei a atividade desorganizada, com pouca orientação e não atendeu às expectativas que eu tinha antes de ir.",
        rating: 2.5,
        date: DateTime.now(),
      ),
      ReviewResponseModel(
        id: "3",
        name: "Mariana",
        comment:
            "Atividade interessante, principalmente para quem está começando. Poderia ter mais opções de horários, mas no geral foi uma boa experiência.",
        rating: 4,
        date: DateTime.now(),
      ),
      ReviewResponseModel(
        id: "4",
        name: "Carlos",
        comment:
            "O local é agradável e a equipe é bastante receptiva. Algumas partes poderiam ser melhor explicadas, mas nada que comprometa a experiência.",
        rating: 4.5,
        date: DateTime.now(),
      ),
      ReviewResponseModel(
        id: "5",
        name: "Ana Paula",
        comment:
            "Não tive uma experiência positiva. Enfrentei atrasos, falta de comunicação e senti que o serviço poderia ser muito melhor pelo valor cobrado.",
        rating: 2,
        date: DateTime.now(),
      ),
      ReviewResponseModel(
        id: "6",
        name: "Rafael",
        comment:
            "Gostei bastante da proposta e da execução. É uma atividade diferente, bem planejada e que realmente agrega valor para quem participa.",
        rating: 4.8,
        date: DateTime.now(),
      ),
      ReviewResponseModel(
        id: "7",
        name: "Beatriz",
        comment:
            "A atividade superou minhas expectativas. Ambiente seguro, bem estruturado e com uma abordagem muito cuidadosa com os participantes.",
        rating: 5,
        date: DateTime.now(),
      ),
    ];

    return reviews;
  }

  Future<List<ReviewResponseModel>> getReviewsByInstanceId(String id) async {
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
