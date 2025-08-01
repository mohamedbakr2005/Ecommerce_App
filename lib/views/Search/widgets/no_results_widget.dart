import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoResultsWidget extends StatelessWidget {
  final String query;

  const NoResultsWidget({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Search Icon
          Icon(
            Icons.search,
            size: 80.sp,
            color: AppColors.gray.withOpacity(0.3),
          ),
          verticalSpace(24),

          // No Results Text
          Text(
            'No Results Found!',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          verticalSpace(8),

          // Suggestion Text
          Text(
            'Try a similar word or something more general.',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.gray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
