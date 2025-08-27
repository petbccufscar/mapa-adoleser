class SubjectModel {
  final int id;
  final String label;

  const SubjectModel({
    required this.id,
    required this.label,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
    };
  }

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      label: json['label'],
    );
  }

  @override
  String toString() => label;
}
