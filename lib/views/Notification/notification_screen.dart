import 'package:e_commerce/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import 'cubit/notification_cubit.dart';
import 'cubit/notification_state.dart';
import 'models/notification_model.dart';
import 'widgets/notification_item.dart';
import 'widgets/notification_empty_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: _buildAppBar(),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is NotificationEmpty) {
            return const NotificationEmptyState();
          } else if (state is NotificationLoaded) {
            return _buildNotificationList(state.notifications);
          } else if (state is NotificationError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.scaffoldBackground,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Notifications',
        style: TextStyle(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            AppIcons.notification,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.black,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () {
            // Handle notification settings or filter
          },
        ),
      ],
    );
  }

  Widget _buildNotificationList(List<NotificationModel> notifications) {
    // Group notifications by date
    final groupedNotifications = _groupNotificationsByDate(notifications);

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: groupedNotifications.length,
      itemBuilder: (context, index) {
        final dateGroup = groupedNotifications.entries.elementAt(index);
        return _buildDateSection(dateGroup.key, dateGroup.value);
      },
    );
  }

  Widget _buildDateSection(String date, List<NotificationModel> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            date,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ),

        // Notifications for this date
        ...notifications
            .map(
              (notification) => Column(
                children: [
                  NotificationItem(notification: notification),
                  if (notifications.last != notification)
                    const Divider(
                      height: 1,
                      color: AppColors.separator,
                      indent: 72,
                      endIndent: 20,
                    ),
                ],
              ),
            )
            ,

        const SizedBox(height: 16),
      ],
    );
  }

  Map<String, List<NotificationModel>> _groupNotificationsByDate(
    List<NotificationModel> notifications,
  ) {
    final grouped = <String, List<NotificationModel>>{};

    for (final notification in notifications) {
      final date = _formatDate(notification.timestamp);
      grouped.putIfAbsent(date, () => []).add(notification);
    }

    return grouped;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final notificationDate = DateTime(date.year, date.month, date.day);

    if (notificationDate == today) {
      return 'Today';
    } else if (notificationDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
