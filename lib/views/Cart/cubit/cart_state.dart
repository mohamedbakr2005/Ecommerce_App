import 'package:e_commerce/views/Cart/models/cart_item_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final bool isLoading;

  CartLoaded({required this.items, this.isLoading = false});

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get vat => subtotal * 0.15; // 15% VAT
  double get shippingFee => items.isNotEmpty ? 80.0 : 0.0;
  double get total => subtotal + vat + shippingFee;
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  CartLoaded copyWith({List<CartItemModel>? items, bool? isLoading}) {
    return CartLoaded(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
