import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/views/ProductDetails/cubit/product_details_cubit.dart';
import 'package:e_commerce/views/ProductDetails/cubit/product_details_state.dart';
import 'package:e_commerce/views/ProductDetails/models/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorSelector extends StatelessWidget {
  const ColorSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state.product == null) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select color',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: state.product!.colors.map((color) {
                final isSelected = state.selectedColor?.name == color.name;
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: GestureDetector(
                    onTap: () =>
                        context.read<ProductDetailsCubit>().selectColor(color),
                    child: Column(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: color.color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.black
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  color: color.color == Colors.white
                                      ? AppColors.black
                                      : Colors.white,
                                  size: 20.sp,
                                )
                              : null,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          color.name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
