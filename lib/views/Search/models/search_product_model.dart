class SearchProductModel {
  final String id;
  final String name;
  final double price;
  final double? originalPrice;
  final int? discount;
  final String image;
  final String category;

  SearchProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    this.discount,
    required this.image,
    required this.category,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: json['originalPrice']?.toDouble(),
      discount: json['discount'],
      image: json['image'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'originalPrice': originalPrice,
      'discount': discount,
      'image': image,
      'category': category,
    };
  }
}
