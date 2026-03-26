import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/responses/instance_response_model.dart';
import 'package:mapa_adoleser/domain/responses/instece_activity_response_model.dart';

class InstanceService {
  Future<InstanceResponseModel> getInstanceById(String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da instância não pode ser vazio');
    }

    if (id == "UUID_INVALIDO") {
      throw FetchDataException('Instância não encontrada');
    }

    final instance = InstanceResponseModel(
      id: 'inst-001',
      name: 'Morning Yoga Session',
      address: 'R. Dr. Donato dos Santos, 397 - São Carlos - SP',
      description: 'Guided yoga session focused on flexibility and breathing.',
      operatingStart: '08:00',
      operatingEnd: '09:30',
      operatingDays: ['Monday', 'Wednesday', 'Friday'],
      ageRangeStart: 16,
      ageRangeEnd: 65,
      accessibility: 'Wheelchair access',
      contactPhone: '+55 16 99999-9999',
      website: 'https://example.com/yoga',
    );

    return instance;
  }

  Future<List<InstanceActivityResponseModel>> getInstancesByActivityId(
      String id) async {
    if (id.trim().isEmpty) {
      throw InvalidParameterException('ID da instância não pode ser vazio');
    }

    if (id == "UUID_INVALIDO") {
      throw FetchDataException('Instância não encontrada');
    }

    final List<InstanceActivityResponseModel> instenceList =
        <InstanceActivityResponseModel>[
      InstanceActivityResponseModel(
        id: "1",
        name: "Prefeitura de São Carlos",
      ),
      InstanceActivityResponseModel(
        id: "3",
        name: "Coletivo de Esportes de São Carlos",
      ),
    ];

    return instenceList;
  }
}
