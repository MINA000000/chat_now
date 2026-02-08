class RoomModel {
  String id;
  final String name;
  final String description;
  final String categoryId;
  RoomModel({
    this.id = '',
    required this.categoryId,
    required this.description,
    required this.name,
  });
  RoomModel.fromJson(Map<String, dynamic> json)
    : this(
        categoryId: json['categoryId'],
        description: json['description'],
        name: json['name'],
      );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'categoryId': categoryId,
  };
}
