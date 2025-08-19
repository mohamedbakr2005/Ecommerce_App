import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Large bell icon
          SvgPicture.asset(
            'assets/icons/notification.svg',
            width: 80,
            height: 80,
            colorFilter: const ColorFilter.mode(
              AppColors.placeholder,
              BlendMode.srcIn,
            ),
          ),

          const SizedBox(height: 24),

          // Title text
          const Text(
            "You haven't gotten any notifications yet!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Subtitle text
          const Text(
            "We'll alert you when something cool happens.",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.placeholder,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
