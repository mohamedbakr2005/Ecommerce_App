import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/Search/models/search_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultItem extends StatelessWidget {
  final SearchProductModel product;
  final void Function()? onTap;

  const SearchResultItem({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            // Product Image
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                image: DecorationImage(
                  image: AssetImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            horizontalSpace(16),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  verticalSpace(4),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      if (product.discount != null) ...[
                        horizontalSpace(8),
                        Text(
                          '-${product.discount}%',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.gray),
          ],
        ),
      ),
    );
  }
}
