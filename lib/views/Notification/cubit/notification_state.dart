import '../models/notification_model.dart';

abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;

  const NotificationLoaded({required this.notifications});
}

class NotificationEmpty extends NotificationState {}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError({required this.message});
}
