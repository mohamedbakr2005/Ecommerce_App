import 'package:e_commerce/views/Checkout/models/checkout_model.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final CheckoutData checkoutData;
  final String? promoCode;
  final bool isPromoCodeApplied;
  final bool isProcessingOrder;

  CheckoutLoaded({
    required this.checkoutData,
    this.promoCode,
    this.isPromoCodeApplied = false,
    this.isProcessingOrder = false,
  });

  CheckoutLoaded copyWith({
    CheckoutData? checkoutData,
    String? promoCode,
    bool? isPromoCodeApplied,
    bool? isProcessingOrder,
  }) {
    return CheckoutLoaded(
      checkoutData: checkoutData ?? this.checkoutData,
      promoCode: promoCode ?? this.promoCode,
      isPromoCodeApplied: isPromoCodeApplied ?? this.isPromoCodeApplied,
      isProcessingOrder: isProcessingOrder ?? this.isProcessingOrder,
    );
  }
}

class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError(this.message);
}

class OrderPlacedSuccess extends CheckoutState {
  final String orderId;

  OrderPlacedSuccess(this.orderId);
}
