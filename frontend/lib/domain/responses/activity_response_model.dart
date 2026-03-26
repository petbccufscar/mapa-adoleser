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

  final double latitude;
  final double longitude;
  final String instanceName;
  final String instanceAddress;
  final int targetAge;

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
    required this.latitude,
    required this.longitude,
    required this.instanceName,
    required this.instanceAddress,
    required this.targetAge,
  });

  factory ActivityResponseModel.fromJson(Map<String, dynamic> json) {
    return ActivityResponseModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      address: json['address'] ?? "",
      description: json['description'] ?? "",
      contact: json['contact_phone'] ?? json['contact_email'] ?? json['contact_socialnetwork'] ?? "",
      operatingStart: json['horario'] != null ? json['horario'].toString().split('T').last.split('.').first : "",
      operatingEnd: "",
      operatingDays: [],
      ageRangeStart: json['target_age'] ?? json['ageRangeStart'] ?? 0,
      ageRangeEnd: json['target_age'] ?? json['ageRangeEnd'] ?? 0,
      accessibility: json['accessibility'] ?? "",
      latitude: double.tryParse(json['latitude']?.toString() ?? '0') ?? 0.0,
      longitude: double.tryParse(json['longitude']?.toString() ?? '0') ?? 0.0,
      instanceName: json['instance_name'] ?? "",
      instanceAddress: json['instance_address'] ?? "",
      targetAge: json['target_age'] ?? 0,
    );
  }
}

