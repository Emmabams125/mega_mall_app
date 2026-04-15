class CategoryModel {
  final int id;
  final String name;
  final String image;
  final int? parentId;
  final String createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId,
    required this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: (json['image']),
      parentId: json['parentId'],
      createdAt: json['createdAt'],
    );
  }
}
