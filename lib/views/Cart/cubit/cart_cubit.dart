import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/views/Cart/models/cart_item_model.dart';
import 'package:e_commerce/views/Cart/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    loadCart();
  }

  void loadCart() {
    emit(CartLoading());

    // Simulate loading cart data
    Future.delayed(const Duration(milliseconds: 500), () {
      // Mock data - replace with actual API call
      final mockItems = [
        CartItemModel(
          id: '1',
          name: 'Regular Fit Slogan',
          image: 'assets/images/home1.png',
          size: 'L',
          price: 1190.0,
          quantity: 2,
        ),
        CartItemModel(
          id: '2',
          name: 'Regular Fit Polo',
          image: 'assets/images/home2.png',
          size: 'M',
          price: 1100.0,
          quantity: 1,
        ),
        CartItemModel(
          id: '3',
          name: 'Regular Fit Black',
          image: 'assets/images/home3.png',
          size: 'L',
          price: 1290.0,
          quantity: 1,
        ),
      ];

      emit(CartLoaded(items: mockItems));
    });
  }

  void addToCart(CartItemModel item) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final existingItemIndex = currentState.items.indexWhere(
        (element) => element.id == item.id,
      );

      List<CartItemModel> updatedItems = List.from(currentState.items);

      if (existingItemIndex != -1) {
        // Update quantity if item already exists
        updatedItems[existingItemIndex] = updatedItems[existingItemIndex]
            .copyWith(quantity: updatedItems[existingItemIndex].quantity + 1);
      } else {
        // Add new item
        updatedItems.add(item);
      }

      emit(CartLoaded(items: updatedItems));
    }
  }

  void removeFromCart(String itemId) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedItems = currentState.items
          .where((item) => item.id != itemId)
          .toList();
      emit(CartLoaded(items: updatedItems));
    }
  }

  void updateQuantity(String itemId, int newQuantity) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;

      if (newQuantity <= 0) {
        removeFromCart(itemId);
        return;
      }

      final updatedItems = currentState.items.map((item) {
        if (item.id == itemId) {
          return item.copyWith(quantity: newQuantity);
        }
        return item;
      }).toList();

      emit(CartLoaded(items: updatedItems));
    }
  }

  void incrementQuantity(String itemId) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final item = currentState.items.firstWhere((item) => item.id == itemId);
      updateQuantity(itemId, item.quantity + 1);
    }
  }

  void decrementQuantity(String itemId) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final item = currentState.items.firstWhere((item) => item.id == itemId);
      updateQuantity(itemId, item.quantity - 1);
    }
  }

  void clearCart() {
    emit(CartLoaded(items: []));
  }

  void checkout() {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      emit(currentState.copyWith(isLoading: true));

      // Simulate checkout process
      Future.delayed(const Duration(seconds: 2), () {
        // Navigate to checkout or show success message
        emit(CartLoaded(items: [])); // Clear cart after successful checkout
      });
    }
  }

  bool get isEmpty {
    if (state is CartLoaded) {
      return (state as CartLoaded).items.isEmpty;
    }
    return true;
  }

  int get itemCount {
    if (state is CartLoaded) {
      return (state as CartLoaded).totalItems;
    }
    return 0;
  }
}
