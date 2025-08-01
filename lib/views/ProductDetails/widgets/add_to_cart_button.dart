import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/views/ProductDetails/cubit/product_details_cubit.dart';
import 'package:e_commerce/views/ProductDetails/cubit/product_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state.product == null) return const SizedBox.shrink();

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                // Price Section
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.gray,
                        ),
                      ),
                      Text(
                        '\$${state.product!.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // Add to Cart Button
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: state.canAddToCart
                        ? () => context.read<ProductDetailsCubit>().addToCart()
                        : null,
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: state.canAddToCart
                            ? AppColors.black
                            : AppColors.gray.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: state.canAddToCart
                                ? Colors.white
                                : AppColors.gray,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: state.canAddToCart
                                  ? Colors.white
                                  : AppColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
