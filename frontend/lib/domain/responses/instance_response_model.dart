class InstanceResponseModel {
  final String id;
  final String name;
  final String address;
  final String description;

  final String operatingStart;
  final String operatingEnd;
  final List<String> operatingDays;

  final int ageRangeStart;
  final int ageRangeEnd;

  final String accessibility;

  final String contactPhone;
  final String website;

  InstanceResponseModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.operatingStart,
    required this.operatingEnd,
    required this.operatingDays,
    required this.ageRangeStart,
    required this.ageRangeEnd,
    required this.accessibility,
    required this.contactPhone,
    required this.website,
  });

  factory InstanceResponseModel.fromJson(Map<String, dynamic> json) {
    return InstanceResponseModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
      operatingStart: json['operatingStart'],
      operatingEnd: json['operatingEnd'],
      operatingDays: List<String>.from(json['operatingDays']),
      ageRangeStart: json['ageRangeStart'],
      ageRangeEnd: json['ageRangeEnd'],
      accessibility: json['accessibility'],
      contactPhone: json['contactPhone'],
      website: json['website'],
    );
  }
}
