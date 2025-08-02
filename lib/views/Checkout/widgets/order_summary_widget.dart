import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/views/Checkout/models/checkout_model.dart';

class OrderSummaryWidget extends StatelessWidget {
  final OrderSummary orderSummary;

  const OrderSummaryWidget({super.key, required this.orderSummary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.gray.withOpacity(0.2),
            width: 1.w,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),

          // Order Breakdown
          _buildSummaryRow(
            'Sub-total',
            '\$ ${orderSummary.subtotal.toStringAsFixed(0)}',
          ),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'VAT (%)',
            '\$ ${orderSummary.vat.toStringAsFixed(2)}',
          ),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'Shipping fee',
            '\$ ${orderSummary.shippingFee.toStringAsFixed(0)}',
          ),
          SizedBox(height: 16.h),

          // Divider
          Container(height: 1.h, color: AppColors.gray.withOpacity(0.2)),
          SizedBox(height: 16.h),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              Text(
                '\$ ${orderSummary.total.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.gray,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
