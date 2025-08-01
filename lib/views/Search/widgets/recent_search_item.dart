import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentSearchItem extends StatelessWidget {
  final String searchTerm;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const RecentSearchItem({
    super.key,
    required this.searchTerm,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.separator, width: 1),
          ),
        ),
        child: Row(
          children: [
            // Search Icon
            Icon(Icons.history, size: 20.sp, color: AppColors.gray),
            horizontalSpace(12),

            // Search Term
            Expanded(
              child: Text(
                searchTerm,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
            ),

            // Remove Button
            InkWell(
              onTap: onRemove,
              child: Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gray.withOpacity(0.1),
                ),
                child: Icon(Icons.close, size: 16.sp, color: AppColors.gray),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
