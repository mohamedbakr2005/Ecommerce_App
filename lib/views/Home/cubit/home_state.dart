import 'package:flutter/material.dart';

class HomeState {
  final bool isLoading;
  final TextEditingController searchController;
  final String selectedCategory;
  final List<String> categories;
  final List<Map<String, dynamic>> products;
  final List<String> favoriteProducts;

  HomeState({
    required this.isLoading,
    required this.searchController,
    required this.selectedCategory,
    required this.categories,
    required this.products,
    required this.favoriteProducts,
  });

  HomeState copyWith({
    bool? isLoading,
    TextEditingController? searchController,
    String? selectedCategory,
    List<String>? categories,
    List<Map<String, dynamic>>? products,
    List<String>? favoriteProducts,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      searchController: searchController ?? this.searchController,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
    );
  }
}
