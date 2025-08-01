import 'package:e_commerce/views/ProductDetails/cubit/product_details_state.dart';
import 'package:e_commerce/views/ProductDetails/models/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsState(isLoading: false));

  Future<void> loadProductDetails(String productId) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock product data
      final product = ProductDetailsModel(
        id: productId,
        name: 'Regular Fit Slogan',
        description:
            'The name says it all, the right size slightly snugs the body leaving enough room for comfort in the sleeves and waist.',
        price: 1190,
        image: 'assets/images/home1.png',
        rating: 4.0,
        reviewCount: 45,
        sizes: ['S', 'M', 'L'],
        colors: [
          ColorOption(name: 'Navy Blue', color: const Color(0xFF1B365D)),
          ColorOption(name: 'Black', color: Colors.black),
          ColorOption(name: 'White', color: Colors.white),
          ColorOption(name: 'Gray', color: Colors.grey),
        ],
        isFavorite: false,
      );

      emit(
        state.copyWith(
          isLoading: false,
          product: product,
          isFavorite: product.isFavorite,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load product details',
        ),
      );
    }
  }

  void selectSize(String size) {
    emit(state.copyWith(selectedSize: size));
  }

  void selectColor(ColorOption color) {
    emit(state.copyWith(selectedColor: color));
  }

  void toggleFavorite() {
    if (state.product != null) {
      final updatedProduct = state.product!.copyWith(
        isFavorite: !state.isFavorite,
      );
      emit(
        state.copyWith(product: updatedProduct, isFavorite: !state.isFavorite),
      );
    }
  }

  void addToCart() {
    if (state.canAddToCart) {
      // Here you would typically add the item to cart
      // For now, we'll just emit a success state or show a message
      print(
        'Added to cart: ${state.product?.name} - Size: ${state.selectedSize}, Color: ${state.selectedColor?.name}',
      );
    }
  }

  void clearSelections() {
    emit(state.copyWith(selectedSize: null, selectedColor: null));
  }
}
