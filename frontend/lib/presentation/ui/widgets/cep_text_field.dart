import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/utils/validators.dart';
import 'package:mapa_adoleser/data/services/address_service.dart';
import 'package:mapa_adoleser/domain/models/address_response_model.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CepTextField extends StatefulWidget {
  final bool enabled;
  final TextEditingController controller;
  final void Function(AddressResponseModel?) onSearch;

  const CepTextField(
      {super.key,
      required this.enabled,
      required this.controller,
      required this.onSearch});

  @override
  State<CepTextField> createState() => _CepTextFieldState();
}

class _CepTextFieldState extends State<CepTextField> {
  late final MaskTextInputFormatter _maskFormatter;

  @override
  void initState() {
    _maskFormatter = MaskTextInputFormatter(
      mask: '#####-###',
      filter: {"#": RegExp(r'[0-9]')},
    );

    if (widget.controller.text.isNotEmpty) {
      fetchAddress(widget.controller.text);
    }

    super.initState();
  }

  void fetchAddress(String cep) async {
    AddressService addressService = AddressService();

    try {
      await addressService.searchCEP(cep).then((address) {
        widget.onSearch(address);
      });
    } catch (e) {
      log('Erro ao buscar endereço: $e');
      widget.onSearch(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      enabled: widget.enabled,
      label: 'CEP',
      controller: widget.controller,
      validator: Validators.isNotEmpty,
      hint: '00000-000',
      keyboardType: TextInputType.number,
      inputFormatters: [_maskFormatter],
      onFieldSubmitted: (cep) {
        fetchAddress(cep);
      },
      suffixIcon: widget.enabled
          ? IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                fetchAddress(widget.controller.text);
              },
            )
          : null,
    );
  }
}
