import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color? filledColor;
  final Color? unfilledColor;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 16,
    this.filledColor,
    this.unfilledColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        final isFilled = starValue <= rating;
        final isHalfFilled = starValue - rating < 1 && starValue - rating > 0;

        return Icon(
          isHalfFilled
              ? Icons.star_half
              : (isFilled ? Icons.star : Icons.star_border),
          size: size.sp,
          color: isFilled || isHalfFilled
              ? (filledColor ?? Colors.amber)
              : (unfilledColor ?? Colors.grey.shade300),
        );
      }),
    );
  }
}
