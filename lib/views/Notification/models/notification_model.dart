class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String iconPath;
  final DateTime timestamp;
  final NotificationType type;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.iconPath,
    required this.timestamp,
    required this.type,
  });
}

enum NotificationType { discount, wallet, location, creditCard, account }

extension NotificationTypeExtension on NotificationType {
  String get iconPath {
    switch (this) {
      case NotificationType.discount:
        return 'assets/icons/discount.svg';
      case NotificationType.wallet:
        return 'assets/icons/wallet.svg';
      case NotificationType.location:
        return 'assets/icons/location.svg';
      case NotificationType.creditCard:
        return 'assets/icons/credit-card.svg';
      case NotificationType.account:
        return 'assets/icons/account.svg';
    }
  }
}
