import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_images.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/MyOrder/widget/time_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackOrderForm extends StatelessWidget {
  const TrackOrderForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.gray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Address',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 24.sp, color: AppColors.black),
                ),
              ],
            ),
          ),

          Container(height: 1.h, color: AppColors.gray.withOpacity(0.2)),

          Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimeLineWidget(),
                Container(height: 1.h, color: AppColors.gray.withOpacity(0.2)),
                verticalSpace(15),
                Row(
                  children: [
                    Image.asset(AppImages.person, width: 60.w, height: 60.h),
                    horizontalSpace(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          verticalSpace(5),
                          Text(
                            'Delivery Guy',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      color: AppColors.primary,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          AppColors.gray.withOpacity(0.3),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.call,
                        color: AppColors.primary,
                        size: 30.sp,
                      ),
                      onPressed: () {
                        // Handle call action
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          verticalSpace(10),
        ],
      ),
    );
  }
}
