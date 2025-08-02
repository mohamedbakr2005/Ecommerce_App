class CartItemModel {
  final String id;
  final String name;
  final String image;
  final String size;
  final double price;
  final int quantity;
  final double originalPrice;
  final double discount;

  CartItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.size,
    required this.price,
    required this.quantity,
    this.originalPrice = 0.0,
    this.discount = 0.0,
  });

  double get totalPrice => price * quantity;
  double get discountedPrice =>
      originalPrice > 0 ? originalPrice * (1 - discount / 100) : price;

  CartItemModel copyWith({
    String? id,
    String? name,
    String? image,
    String? size,
    double? price,
    int? quantity,
    double? originalPrice,
    double? discount,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      size: size ?? this.size,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      originalPrice: originalPrice ?? this.originalPrice,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'size': size,
      'price': price,
      'quantity': quantity,
      'originalPrice': originalPrice,
      'discount': discount,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      size: json['size'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      originalPrice: json['originalPrice']?.toDouble() ?? 0.0,
      discount: json['discount']?.toDouble() ?? 0.0,
    );
  }
}
