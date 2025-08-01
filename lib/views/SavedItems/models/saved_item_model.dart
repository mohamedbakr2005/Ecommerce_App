class SavedItemModel {
  final String id;
  final String name;
  final double price;
  final double? originalPrice;
  final int? discount;
  final String image;
  final String category;
  final bool isFavorite;

  SavedItemModel({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    this.discount,
    required this.image,
    required this.category,
    this.isFavorite = true,
  });

  SavedItemModel copyWith({
    String? id,
    String? name,
    double? price,
    double? originalPrice,
    int? discount,
    String? image,
    String? category,
    bool? isFavorite,
  }) {
    return SavedItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      discount: discount ?? this.discount,
      image: image ?? this.image,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'originalPrice': originalPrice,
      'discount': discount,
      'image': image,
      'category': category,
      'isFavorite': isFavorite,
    };
  }

  factory SavedItemModel.fromMap(Map<String, dynamic> map) {
    return SavedItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] as num).toDouble(),
      originalPrice: map['originalPrice'] != null
          ? (map['originalPrice'] as num).toDouble()
          : null,
      discount: map['discount']?.toInt(),
      image: map['image'] ?? '',
      category: map['category'] ?? '',
      isFavorite: map['isFavorite'] ?? true,
    );
  }
}
