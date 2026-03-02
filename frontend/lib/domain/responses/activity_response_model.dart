class ActivityResponseModel {
  final String id;
  final String name;
  final String address;
  final String description;
  final String contact;

  final String operatingStart;
  final String operatingEnd;
  final List<String> operatingDays;

  final int ageRangeStart;
  final int ageRangeEnd;

  final String accessibility;

  ActivityResponseModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.contact,
    required this.operatingStart,
    required this.operatingEnd,
    required this.operatingDays,
    required this.ageRangeStart,
    required this.ageRangeEnd,
    required this.accessibility,
  });

  factory ActivityResponseModel.fromJson(Map<String, dynamic> json) {
    return ActivityResponseModel(
      id: json['id'],
      name: json['name'] ?? "",
      address: json['address'] ?? "",
      description: json['description'] ?? "",
      contact: json['contact'] ?? "",
      operatingStart: json['operatingStart'] ?? "",
      operatingEnd: json['operatingEnd'] ?? "",
      operatingDays: List<String>.from(json['operatingDays']),
      ageRangeStart: json['ageRangeStart'] ?? 0,
      ageRangeEnd: json['ageRangeEnd'] ?? 0,
      accessibility: json['accessibility'] ?? "",
    );
  }
}
