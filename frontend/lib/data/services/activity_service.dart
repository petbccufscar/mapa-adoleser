import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/models/activity_model.dart';
import 'package:mapa_adoleser/domain/models/activity_response_model.dart';
import 'package:mapa_adoleser/domain/models/subject_model.dart';
import 'package:mapa_adoleser/domain/models/tag_model.dart';

class ActivityService {
  Future<ActivityModel> getActivityById(String id) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da atividade não pode ser vazio');
    }

    if (id == "UUID_INVALIDO") {
      throw FetchDataException('Atividade não encontrada');
    }

    // Simula sucesso
    return ActivityModel(
        id: 1,
        locationId: '1',
        name: 'Praça do Kartodromo',
        tags: [
          TagModel(id: 1, label: 'Lazer'),
          TagModel(id: 2, label: 'Esporte'),
          TagModel(id: 3, label: 'Cultura'),
        ]
        description: 'Descrição da Atividade 1',
        date: DateTime.now());
  }

  Future<List<SubjectModel>> fetchSubjects() async {
    await Future.delayed(const Duration(seconds: 2));

    final List<SubjectModel> subjectList = <SubjectModel>[
      SubjectModel(
        id: 1,
        label: 'Suporte Técnico',
      ),
      SubjectModel(
        id: 2,
        label: 'Dúvidas Gerais',
      ),
      SubjectModel(
        id: 3,
        label: 'Feedback',
      ),
    ];

    return subjectList;
  }
}