import 'package:e_commerce/core/constants/app_images.dart';
import 'package:e_commerce/views/MyOrder/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit()
    : super(
        OrdersState(
          selectedTab: OrderStatus.ongoing,
          ongoingOrders: [
            Order(
              name: "Regular Fit Slogan",
              size: "M",
              price: 1190,
              status: "In Transit",
              action: "Track Order",
              imageUrl: AppImages.home1,
            ),
            Order(
              name: "Regular Fit Polo",
              size: "L",
              price: 1100,
              status: "Picked",
              action: "Track Order",
              imageUrl: AppImages.home2,
            ),
            Order(
              name: "Regular Fit Black",
              size: "L",
              price: 1690,
              status: "In Transit",
              action: "Track Order",
              imageUrl: AppImages.home3,
            ),
            Order(
              name: "Regular Fit V-Neck",
              size: "S",
              price: 1290,
              status: "Packing",
              action: "Track Order",
              imageUrl: AppImages.home4,
            ),
            Order(
              name: "Regular Fit Pink",
              size: "M",
              price: 1341,
              status: "Picked",
              action: "Track Order",
              imageUrl: AppImages.home2,
            ),
          ],
          completedOrders: [
            Order(
              name: "Regular Fit Slogan",
              size: "M",
              price: 1190,
              status: "Completed",
              action: "Leave Review",
              imageUrl: AppImages.home1,
            ),
            Order(
              name: "Regular Fit Polo",
              size: "L",
              price: 1100,
              status: "Completed",
              action: "4.5/5",
              imageUrl: AppImages.home2,
            ),
            Order(
              name: "Regular Fit Black",
              size: "L",
              price: 1690,
              status: "Completed",
              action: "Leave Review",
              imageUrl: AppImages.home3,
            ),
            Order(
              name: "Regular Fit V-Neck",
              size: "S",
              price: 1290,
              status: "Completed",
              action: "Leave Review",
              imageUrl: AppImages.home4,
            ),
            Order(
              name: "Regular Fit Pink",
              size: "M",
              price: 1341,
              status: "Completed",
              action: "3.5/5",
              imageUrl: AppImages.home1,
            ),
          ],
          isLoading: false,
        ),
      );

  void changeTab(OrderStatus tab) {
    emit(
      OrdersState(
        isLoading: state.isLoading,
        selectedTab: tab,
        ongoingOrders: state.ongoingOrders,
        completedOrders: state.completedOrders,
      ),
    );
  }
}
