class AddressResponseModel {
  final String city;
  final String cep;
  final String state;
  final String uf;
  final String street;
  final String neighborhood;

  const AddressResponseModel({
    required this.city,
    required this.cep,
    required this.state,
    required this.uf,
    required this.street,
    required this.neighborhood,
  });

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) {
    return AddressResponseModel(
      city: json['localidade'] ?? '',
      cep: json['cep'] ?? '',
      uf: json['uf'] ?? '',
      state: json['estado'] ?? '',
      street: json['logradouro'] ?? '',
      neighborhood: json['bairro'] ?? '',
    );
  }

  @override
  String toString() {
    return 'AddressResponseModel(city: $city, cep: $cep, state: $state, uf: $uf, street: $street, neighborhood: $neighborhood)';
  }
}
