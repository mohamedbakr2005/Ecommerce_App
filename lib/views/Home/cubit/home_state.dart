import 'package:flutter/material.dart';

class HomeState {
  final bool isLoading;
  final TextEditingController searchController;
  final String selectedCategory;
  final List<String> categories;
  final List<Map<String, dynamic>> products;
  final List<String> favoriteProducts;
  final String sortBy;
  final RangeValues priceRange;
  final String selectedSize;

  HomeState({
    required this.isLoading,
    required this.searchController,
    required this.selectedCategory,
    required this.categories,
    required this.products,
    required this.favoriteProducts,
    required this.sortBy,
    required this.priceRange,
    required this.selectedSize,
  });

  HomeState copyWith({
    bool? isLoading,
    TextEditingController? searchController,
    String? selectedCategory,
    List<String>? categories,
    List<Map<String, dynamic>>? products,
    List<String>? favoriteProducts,
    String? sortBy,
    RangeValues? priceRange,
    String? selectedSize,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      searchController: searchController ?? this.searchController,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      sortBy: sortBy ?? this.sortBy,
      priceRange: priceRange ?? this.priceRange,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }
}
