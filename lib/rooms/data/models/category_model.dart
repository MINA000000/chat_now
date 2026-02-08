class CategoryModel {
  final String id;
  final String name;
  final String imageName;
  CategoryModel({
    required this.id,
    required this.imageName,
    required this.name,
  });
  static final categories = [
    CategoryModel(id: 'sports', imageName: 'sports', name: 'Sports'),
    CategoryModel(id: 'music', imageName: 'music', name: 'Music'),
    CategoryModel(id: 'movies', imageName: 'movies', name: 'Movies'),
  ];
}
