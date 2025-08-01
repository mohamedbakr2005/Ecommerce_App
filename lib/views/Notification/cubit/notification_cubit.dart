import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/notification_model.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  void loadNotifications() {
    emit(NotificationLoading());

    // Simulate API call delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final notifications = _getMockNotifications();

      if (notifications.isEmpty) {
        emit(NotificationEmpty());
      } else {
        emit(NotificationLoaded(notifications: notifications));
      }
    });
  }

  void clearNotifications() {
    emit(NotificationEmpty());
  }

  List<NotificationModel> _getMockNotifications() {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final june7 = DateTime(2023, 6, 7);

    return [
      NotificationModel(
        id: '1',
        title: '30% Special Discount!',
        message: 'Special promotion only valid today.',
        iconPath: 'assets/icons/discount.svg',
        timestamp: now,
        type: NotificationType.discount,
      ),
      NotificationModel(
        id: '2',
        title: 'Top Up E-wallet Successfully!',
        message: 'You have top up your e-wallet.',
        iconPath: 'assets/icons/wallet.svg',
        timestamp: yesterday,
        type: NotificationType.wallet,
      ),
      NotificationModel(
        id: '3',
        title: 'New Service Available!',
        message: 'Now you can track order in real-time.',
        iconPath: 'assets/icons/location.svg',
        timestamp: yesterday,
        type: NotificationType.location,
      ),
      NotificationModel(
        id: '4',
        title: 'Credit Card Connected!',
        message: 'Credit card has been linked.',
        iconPath: 'assets/icons/credit-card.svg',
        timestamp: june7,
        type: NotificationType.creditCard,
      ),
      NotificationModel(
        id: '5',
        title: 'Account Setup Successfully!',
        message: 'Your account has been created.',
        iconPath: 'assets/icons/account.svg',
        timestamp: june7,
        type: NotificationType.account,
      ),
    ];
  }
}
