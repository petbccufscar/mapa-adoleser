class Subject {
  final int id;
  final String label;

  const Subject({
    required this.id,
    required this.label,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
    };
  }

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      label: json['label'],
    );
  }

  @override
  String toString() => label;
}
