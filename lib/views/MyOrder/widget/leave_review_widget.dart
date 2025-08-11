import 'package:e_commerce/core/components/app_button.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/MyOrder/widget/star_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveReviewWidget extends StatelessWidget {
  const LeaveReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.gray.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Leave Review',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),

            Container(height: 1.h, color: AppColors.gray.withOpacity(0.2)),

            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How was your order?",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    "Please give your rating and also your review.",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray,
                    ),
                  ),
                  verticalSpace(15),
                  Center(child: StarRatingWidget()),
                  verticalSpace(25),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Write your review...",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.w),
                        borderSide: BorderSide(
                          color: AppColors.placeholder,
                          strokeAlign: 2,
                          width: 1.8,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.w),
                        borderSide: BorderSide(
                          color: AppColors.placeholder,
                          strokeAlign: 2,
                          width: 1.8,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.w),
                        borderSide: BorderSide(
                          color: AppColors.placeholder,
                          strokeAlign: 2,
                          width: 1.8,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(20),
                  AppButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Submit",
                  ),
                ],
              ),
            ),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }
}
