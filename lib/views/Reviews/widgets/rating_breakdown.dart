import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/Reviews/models/review_model.dart';
import 'package:e_commerce/views/Reviews/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingBreakdownWidget extends StatelessWidget {
  final RatingBreakdown ratingBreakdown;

  const RatingBreakdownWidget({super.key, required this.ratingBreakdown});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 5; i >= 1; i--)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              children: [
                // Stars
                SizedBox(
                  width: 80.w,
                  child: StarRating(
                    rating: i.toDouble(),
                    size: 14,
                    filledColor: Colors.amber,
                    unfilledColor: Colors.grey.shade300,
                  ),
                ),
                horizontalSpace(8),

                // Progress bar
                Expanded(
                  child: Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: ratingBreakdown.getPercentage(i),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                      ),
                    ),
                  ),
                ),
                horizontalSpace(8),

                // Count
                SizedBox(
                  width: 40.w,
                  child: Text(
                    _getCountForRating(i).toString(),
                    style: TextStyle(fontSize: 12.sp, color: AppColors.gray),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  int _getCountForRating(int rating) {
    switch (rating) {
      case 5:
        return ratingBreakdown.fiveStar;
      case 4:
        return ratingBreakdown.fourStar;
      case 3:
        return ratingBreakdown.threeStar;
      case 2:
        return ratingBreakdown.twoStar;
      case 1:
        return ratingBreakdown.oneStar;
      default:
        return 0;
    }
  }
}
