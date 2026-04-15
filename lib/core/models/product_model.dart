class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final int categoryId;
  final String createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryId,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: (json['image']),
      categoryId: json['categoryId'],
      createdAt: json['createdAt'],
    );
  }
}
