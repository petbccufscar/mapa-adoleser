import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/responses/activity_response_model.dart';
import 'package:mapa_adoleser/domain/responses/related_activity_response_model.dart';

class ActivityService {
  Future<ActivityResponseModel> getActivityById(String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da atividade não pode ser vazio');
    }

    if (id == "UUID_INVALIDO") {
      throw FetchDataException('Atividade não encontrada');
    }

    // Simula sucesso
    return ActivityResponseModel(
      id: "1",
      name: 'Praça do Kartodromo',
      description:
          'O Parque do Kartódromo é um espaço de lazer e recreação ao ar livre, ideal para quem busca contato com a natureza e atividades esportivas. Com amplas áreas verdes, pistas para caminhadas e ciclismo, playgrounds e espaços para piqueniques, o parque se tornou um ponto de encontro para famílias, atletas e amantes do ar livre. Seu nome faz referência ao kartódromo localizado nas proximidades, que atrai entusiastas da velocidade. Além disso, o local conta com infraestrutura para eventos, quadras esportivas e um ambiente agradável para descanso e convivência.',
      contact: '(14) 97567-8856',
      address:
          'R. Dr. Donato dos Santos, 397 - Jardim Nova Santa Paula, São Carlos - SP, 13564-332',
      operatingStart: '6h',
      operatingEnd: '22h',
      operatingDays: ["Todos os dias"],
      ageRangeStart: 0,
      ageRangeEnd: 0,
      accessibility: 'Acessível para cadeirantes',
    );
  }

  Future<List<RelatedActivityResponseModel>> getRelatedActivitiesById(
      String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da atividade não pode ser vazio');
    }

    if (id == "UUID_INVALIDO") {
      throw FetchDataException('Atividade não encontrada');
    }

    final List<RelatedActivityResponseModel> activities =
        <RelatedActivityResponseModel>[
      RelatedActivityResponseModel(
        id: "2",
        name: 'Praça XV de Novembro',
        averageRating: 4.9,
        ratingCount: 24,
      ),
      RelatedActivityResponseModel(
        id: "3",
        name: 'Praça da Bandeira',
        averageRating: 4.5,
        ratingCount: 58,
      ),
      RelatedActivityResponseModel(
        id: "4",
        name: 'Parque Ecológico',
        averageRating: 4.8,
        ratingCount: 124,
      ),
      RelatedActivityResponseModel(
        id: "5",
        name: 'Museu de Ciência',
        averageRating: 4.2,
        ratingCount: 37,
      ),
      RelatedActivityResponseModel(
        id: "6",
        name: 'Lagoa Serena',
        averageRating: 4.6,
        ratingCount: 89,
      ),
      RelatedActivityResponseModel(
        id: "7",
        name: 'Teatro Municipal',
        averageRating: 4.4,
        ratingCount: 211,
      ),
      RelatedActivityResponseModel(
        id: "8",
        name: 'Feira Central',
        averageRating: 4.1,
        ratingCount: 64,
      ),
      RelatedActivityResponseModel(
        id: "9",
        name: 'Mirante do Horizonte',
        averageRating: 4.9,
        ratingCount: 18,
      ),
      RelatedActivityResponseModel(
        id: "10",
        name: 'Biblioteca Comunitária',
        averageRating: 4.3,
        ratingCount: 42,
      ),
    ];

    return activities;
  }

  Future<List<RelatedActivityResponseModel>> getActivitiesByInstanceId(
      String id) async {
    final List<RelatedActivityResponseModel> activities =
        <RelatedActivityResponseModel>[
      RelatedActivityResponseModel(
        id: "2",
        name: 'Praça XV de Novembro',
        averageRating: 4.9,
        ratingCount: 24,
      ),
      RelatedActivityResponseModel(
        id: "3",
        name: 'Praça da Bandeira',
        averageRating: 4.5,
        ratingCount: 58,
      ),
    ];

    return activities;
  }
}
