import 'package:mapa_adoleser/core/errors/app_exception.dart';
import 'package:mapa_adoleser/domain/models/contact_request_model.dart';
import 'package:mapa_adoleser/domain/models/contact_response_model.dart';
import 'package:mapa_adoleser/domain/models/subject_model.dart';

class ContactService {
  Future<ContactResponse> sendContact(ContactRequest data) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula chamada à API

    if (data.email == 'vini.cotrim@hotmail.com') {
      throw ContactException();
    }

    // Simula sucesso
    return const ContactResponse(success: true);
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
