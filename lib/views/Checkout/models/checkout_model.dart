class DeliveryAddress {
  final String label;
  final String address;
  final String fullAddress;

  DeliveryAddress({
    required this.label,
    required this.address,
    required this.fullAddress,
  });
}

class PaymentMethod {
  final String id;
  final String type;
  final String name;
  final String cardNumber;
  final String cardType;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.name,
    required this.cardNumber,
    required this.cardType,
  });
}

class OrderSummary {
  final double subtotal;
  final double vat;
  final double shippingFee;
  final double total;

  OrderSummary({
    required this.subtotal,
    required this.vat,
    required this.shippingFee,
    required this.total,
  });
}

class CheckoutData {
  final DeliveryAddress deliveryAddress;
  final PaymentMethod selectedPaymentMethod;
  final List<PaymentMethod> availablePaymentMethods;
  final OrderSummary orderSummary;
  final String? promoCode;

  CheckoutData({
    required this.deliveryAddress,
    required this.selectedPaymentMethod,
    required this.availablePaymentMethods,
    required this.orderSummary,
    this.promoCode,
  });
}
