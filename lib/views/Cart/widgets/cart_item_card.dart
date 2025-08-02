import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/Cart/models/cart_item_model.dart';
import 'package:e_commerce/views/Cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(color: AppColors.gray.withOpacity(0.2), width: 1.w),
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              image: DecorationImage(
                image: AssetImage(item.image),
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
                  item.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(4),
                Text(
                  "Size ${item.size}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray,
                  ),
                ),
                verticalSpace(8),
                Text(
                  "\$${item.price.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Column(
            children: [
              // Quantity Selector
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.gray.withOpacity(0.3),
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Decrease Button
                    GestureDetector(
                      onTap: () =>
                          context.read<CartCubit>().decrementQuantity(item.id),
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.w),
                            bottomLeft: Radius.circular(8.w),
                          ),
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 16.sp,
                          color: AppColors.black,
                        ),
                      ),
                    ),

                    // Quantity Display
                    Container(
                      width: 40.w,
                      height: 32.h,
                      alignment: Alignment.center,
                      child: Text(
                        item.quantity.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ),

                    // Increase Button
                    GestureDetector(
                      onTap: () =>
                          context.read<CartCubit>().incrementQuantity(item.id),
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.w),
                            bottomRight: Radius.circular(8.w),
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16.sp,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(8),

              // Remove Button
              GestureDetector(
                onTap: () => context.read<CartCubit>().removeFromCart(item.id),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(6.w),
                    border: Border.all(color: Colors.red.shade200, width: 1.w),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 16.sp,
                        color: Colors.red,
                      ),
                      horizontalSpace(4),
                      Text(
                        "Remove",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
