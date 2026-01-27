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
        address:
            'R. Dr. Donato dos Santos, 397 - Jardim Nova Santa Paula, São Carlos - SP, 13564-332',
        operatingStart: '6h',
        operatingEnd: '22h',
        operatingDays: ["Todos os dias"],
        ageRangeStart: 0,
        ageRangeEnd: 0,
        accessibility: 'Acessível para cadeirantes',
        phone: '(14) 4002-8922',
        website: 'meusisu.com');
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
        address:
            'R. 15 de Novembro, 1593-1483 - Centro, São Carlos - SP, 13560-110',
        averageRating: 4.9,
        ratingCount: 24,
      ),
      RelatedActivityResponseModel(
        id: "3",
        name: 'Praça da Bandeira',
        address: 'UFSCar - Universidade Federal de São Carlos',
        averageRating: 4.5,
        ratingCount: 58,
      ),
    ];

    return activities;
  }

  Future<List<RelatedActivityResponseModel>> getActivitiesByInstanceId(
      String id) async {
    await Future.delayed(const Duration(seconds: 2));

    final List<RelatedActivityResponseModel> activities =
        <RelatedActivityResponseModel>[
      RelatedActivityResponseModel(
        id: "2",
        name: 'Praça XV de Novembro',
        address:
            'R. 15 de Novembro, 1593-1483 - Centro, São Carlos - SP, 13560-110',
        averageRating: 4.9,
        ratingCount: 24,
      ),
      RelatedActivityResponseModel(
        id: "3",
        name: 'Praça da Bandeira',
        address: 'UFSCar - Universidade Federal de São Carlos',
        averageRating: 4.5,
        ratingCount: 58,
      ),
    ];

    return activities;
  }
}
