import 'package:e_commerce/views/ProductDetails/models/product_details_model.dart';

class ProductDetailsState {
  final bool isLoading;
  final ProductDetailsModel? product;
  final String? selectedSize;
  final ColorOption? selectedColor;
  final String? error;
  final bool isFavorite;

  ProductDetailsState({
    required this.isLoading,
    this.product,
    this.selectedSize,
    this.selectedColor,
    this.error,
    this.isFavorite = false,
  });

  ProductDetailsState copyWith({
    bool? isLoading,
    ProductDetailsModel? product,
    String? selectedSize,
    ColorOption? selectedColor,
    String? error,
    bool? isFavorite,
  }) {
    return ProductDetailsState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      error: error ?? this.error,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  bool get canAddToCart => selectedSize != null && selectedColor != null;
}
