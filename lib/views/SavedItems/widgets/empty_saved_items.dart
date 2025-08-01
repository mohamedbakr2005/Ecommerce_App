import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptySavedItems extends StatelessWidget {
  const EmptySavedItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Heart Icon
          SvgPicture.asset(
            'assets/icons/fav.svg',
            width: 80.w,
            height: 80.h,
            colorFilter: const ColorFilter.mode(
              AppColors.gray,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 24.h),

          // Title
          Text(
            'No Saved Items!',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 8.h),

          // Subtitle
          Text(
            'You don\'t have any saved items.',
            style: TextStyle(fontSize: 14.sp, color: AppColors.gray),
          ),
          SizedBox(height: 4.h),

          Text(
            'Go to home and add some.',
            style: TextStyle(fontSize: 14.sp, color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
