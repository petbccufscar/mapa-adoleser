import 'package:flutter/material.dart';
import 'package:mapa_adoleser/data/services/adress_service.dart';
import 'package:mapa_adoleser/domain/models/adress_response_model.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';

class CepTextField extends StatelessWidget {
  final bool enabled;
  final TextEditingController controller;
  final void Function(AddressResponseModel?) onSearch;

  const CepTextField(
      {super.key,
      required this.enabled,
      required this.controller,
      required this.onSearch});

  Future<AddressResponseModel?> fetchAddress(String cep) async {
    AddressService addressService = AddressService();

    try {
      return await addressService.searchCEP(cep);
    } catch (e) {
      debugPrint('Erro ao buscar endereço: $e');
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      enabled: enabled,
      label: 'CEP',
      controller: controller,
      hint: '00000-000',
      keyboardType: TextInputType.number,
      suffixIcon: enabled
          ? IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                final AddressResponseModel? address =
                    await fetchAddress(controller.text);

                onSearch(address);
              },
            )
          : null,
    );
  }
}
