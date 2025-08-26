class AdressReesponse {
  final String city;
  final String cep;
  final String state;
  final String street;
  final String neighborhood;

  const AdressReesponse({
    required this.city,
    required this.cep,
    required this.state,
    required this.street,
    required this.neighborhood,
  });

  factory AdressReesponse.fromJson(Map<String, dynamic> json) {
    return AdressReesponse(
      city: json['city'],
      cep: json['cep'],
      state: json['state'],
      street: json['street'],
      neighborhood: json['neighborhood'],
    );
  }
}
