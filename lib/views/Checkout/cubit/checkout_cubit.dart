import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/views/Checkout/models/checkout_model.dart';
import 'package:e_commerce/views/Checkout/cubit/checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial()) {
    loadCheckoutData();
  }

  void loadCheckoutData() {
    emit(CheckoutLoading());

    // Simulate loading checkout data
    Future.delayed(const Duration(milliseconds: 500), () {
      // Mock data - replace with actual API call
      final deliveryAddress = DeliveryAddress(
        label: 'Home',
        address: '925 S Chugach St #APT 10',
        fullAddress: '925 S Chugach St #APT 10, Alaska 99645',
      );

      final availablePaymentMethods = [
        PaymentMethod(
          id: '1',
          type: 'card',
          name: 'VISA',
          cardNumber: '**** **** **** 2512',
          cardType: 'VISA',
        ),
        PaymentMethod(
          id: '2',
          type: 'cash',
          name: 'Cash on Delivery',
          cardNumber: '',
          cardType: '',
        ),
        PaymentMethod(
          id: '3',
          type: 'apple_pay',
          name: 'Apple Pay',
          cardNumber: '',
          cardType: '',
        ),
      ];

      final orderSummary = OrderSummary(
        subtotal: 5870.0,
        vat: 0.0,
        shippingFee: 80.0,
        total: 5950.0,
      );

      final checkoutData = CheckoutData(
        deliveryAddress: deliveryAddress,
        selectedPaymentMethod: availablePaymentMethods[0], // Default to card
        availablePaymentMethods: availablePaymentMethods,
        orderSummary: orderSummary,
      );

      emit(CheckoutLoaded(checkoutData: checkoutData));
    });
  }

  void selectPaymentMethod(String paymentMethodId) {
    if (state is CheckoutLoaded) {
      final currentState = state as CheckoutLoaded;
      final selectedMethod = currentState.checkoutData.availablePaymentMethods
          .firstWhere((method) => method.id == paymentMethodId);

      final updatedCheckoutData = CheckoutData(
        deliveryAddress: currentState.checkoutData.deliveryAddress,
        selectedPaymentMethod: selectedMethod,
        availablePaymentMethods:
            currentState.checkoutData.availablePaymentMethods,
        orderSummary: currentState.checkoutData.orderSummary,
        promoCode: currentState.checkoutData.promoCode,
      );

      emit(currentState.copyWith(checkoutData: updatedCheckoutData));
    }
  }

  void applyPromoCode(String promoCode) {
    if (state is CheckoutLoaded) {
      final currentState = state as CheckoutLoaded;

      // Simulate promo code validation
      Future.delayed(const Duration(milliseconds: 300), () {
        // Mock validation - replace with actual API call
        bool isValidPromoCode = promoCode.isNotEmpty && promoCode.length >= 3;

        if (isValidPromoCode) {
          // Apply discount (10% off for demo)
          final originalOrderSummary = currentState.checkoutData.orderSummary;
          final discount = originalOrderSummary.subtotal * 0.1;
          final newSubtotal = originalOrderSummary.subtotal - discount;
          final newTotal =
              newSubtotal +
              originalOrderSummary.vat +
              originalOrderSummary.shippingFee;

          final updatedOrderSummary = OrderSummary(
            subtotal: newSubtotal,
            vat: originalOrderSummary.vat,
            shippingFee: originalOrderSummary.shippingFee,
            total: newTotal,
          );

          final updatedCheckoutData = CheckoutData(
            deliveryAddress: currentState.checkoutData.deliveryAddress,
            selectedPaymentMethod:
                currentState.checkoutData.selectedPaymentMethod,
            availablePaymentMethods:
                currentState.checkoutData.availablePaymentMethods,
            orderSummary: updatedOrderSummary,
            promoCode: promoCode,
          );

          emit(
            currentState.copyWith(
              checkoutData: updatedCheckoutData,
              promoCode: promoCode,
              isPromoCodeApplied: true,
            ),
          );
        } else {
          emit(CheckoutError('Invalid promo code'));
        }
      });
    }
  }

  void removePromoCode() {
    if (state is CheckoutLoaded) {
      final currentState = state as CheckoutLoaded;

      // Reset to original order summary
      final originalOrderSummary = OrderSummary(
        subtotal: 5870.0,
        vat: 0.0,
        shippingFee: 80.0,
        total: 5950.0,
      );

      final updatedCheckoutData = CheckoutData(
        deliveryAddress: currentState.checkoutData.deliveryAddress,
        selectedPaymentMethod: currentState.checkoutData.selectedPaymentMethod,
        availablePaymentMethods:
            currentState.checkoutData.availablePaymentMethods,
        orderSummary: originalOrderSummary,
        promoCode: null,
      );

      emit(
        currentState.copyWith(
          checkoutData: updatedCheckoutData,
          promoCode: null,
          isPromoCodeApplied: false,
        ),
      );
    }
  }

  void placeOrder() {
    if (state is CheckoutLoaded) {
      final currentState = state as CheckoutLoaded;

      emit(currentState.copyWith(isProcessingOrder: true));

      // Simulate order placement
      Future.delayed(const Duration(seconds: 2), () {
        // Mock order placement - replace with actual API call
        final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';
        emit(OrderPlacedSuccess(orderId));
      });
    }
  }

  void resetState() {
    emit(CheckoutInitial());
  }
}
