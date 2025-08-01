import 'package:flutter/material.dart';

class ProductDetailsModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final int? discount;
  final String image;
  final double rating;
  final int reviewCount;
  final List<String> sizes;
  final List<ColorOption> colors;
  final bool isFavorite;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    this.discount,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.sizes,
    required this.colors,
    this.isFavorite = false,
  });

  ProductDetailsModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    int? discount,
    String? image,
    double? rating,
    int? reviewCount,
    List<String>? sizes,
    List<ColorOption>? colors,
    bool? isFavorite,
  }) {
    return ProductDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      discount: discount ?? this.discount,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class ColorOption {
  final String name;
  final Color color;
  final bool isAvailable;

  ColorOption({
    required this.name,
    required this.color,
    this.isAvailable = true,
  });

  ColorOption copyWith({String? name, Color? color, bool? isAvailable}) {
    return ColorOption(
      name: name ?? this.name,
      color: color ?? this.color,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
