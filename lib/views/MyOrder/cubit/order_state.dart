enum OrderStatus { ongoing, completed }

class Order {
  final String name;
  final String size;
  final double price;
  final String status;
  final String action;
  final String? imageUrl;

  Order({
    required this.name,
    required this.size,
    required this.price,
    required this.status,
    required this.action,
    this.imageUrl,
  });
}

class OrdersState {
  final OrderStatus selectedTab;
  final List<Order> ongoingOrders;
  final List<Order> completedOrders;
  final bool isLoading;

  OrdersState({
    required this.selectedTab,
    required this.ongoingOrders,
    required this.completedOrders,
    required this.isLoading,
  });

  OrdersState copyWith({
    OrderStatus? selectedTab,
    List<Order>? ongoingOrders,
    List<Order>? completedOrders,
    bool? isLoading,
  }) {
    return OrdersState(
      isLoading: isLoading ?? this.isLoading,
      selectedTab: selectedTab ?? this.selectedTab,
      ongoingOrders: ongoingOrders ?? this.ongoingOrders,
      completedOrders: completedOrders ?? this.completedOrders,
    );
  }
}
