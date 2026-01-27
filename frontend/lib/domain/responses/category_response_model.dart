class CategoryResponseModel {
  final String id;
  final String name;

  CategoryResponseModel({
    required this.id,
    required this.name,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryResponseModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
