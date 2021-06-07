class CarModel {
  CarModel({
    required this.id,
    required this.name,
    required this.description,
  });

  final int id;
  final String name;
  final String description;

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
    id: json['id'] == null ? null : json['id'],
    name: json['name'] == null ? null : json['name'],
    description: json['description'] == null ? null : json['description'],
  );
}
