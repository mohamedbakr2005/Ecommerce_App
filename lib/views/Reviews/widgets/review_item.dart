import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/Reviews/models/review_model.dart';
import 'package:e_commerce/views/Reviews/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewItem extends StatelessWidget {
  final ReviewModel review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stars and time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StarRating(
                rating: review.rating,
                size: 16,
                filledColor: Colors.amber,
                unfilledColor: Colors.grey.shade300,
              ),
              Text(
                review.timeAgo,
                style: TextStyle(fontSize: 12.sp, color: AppColors.gray),
              ),
            ],
          ),
          verticalSpace(8),

          // Comment
          Text(
            review.comment,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.black,
              height: 1.4,
            ),
          ),
          verticalSpace(8),

          // Reviewer name
          Text(
            review.reviewerName,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.gray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
