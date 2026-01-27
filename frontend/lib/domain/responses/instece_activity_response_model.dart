class InstanceActivityResponseModel {
  final String id;
  final String name;

  InstanceActivityResponseModel({
    required this.id,
    required this.name,
  });

  factory InstanceActivityResponseModel.fromJson(Map<String, dynamic> json) {
    return InstanceActivityResponseModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
