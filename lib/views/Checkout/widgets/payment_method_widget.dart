import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/views/Checkout/models/checkout_model.dart';

class PaymentMethodWidget extends StatelessWidget {
  final List<PaymentMethod> availablePaymentMethods;
  final PaymentMethod selectedPaymentMethod;
  final Function(String) onPaymentMethodSelected;
  final VoidCallback? onEditCard;

  const PaymentMethodWidget({
    super.key,
    required this.availablePaymentMethods,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
    this.onEditCard,
  });

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
            'Payment Method',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),

          // Payment Method Options
          Row(
            children: availablePaymentMethods.map((method) {
              final isSelected = selectedPaymentMethod.id == method.id;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onPaymentMethodSelected(method.id),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: method.id != availablePaymentMethods.last.id
                          ? 8.w
                          : 0,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 8.w,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.black : AppColors.white,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.black
                            : AppColors.gray.withOpacity(0.3),
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getPaymentIcon(method.type),
                          size: 16.sp,
                          color: isSelected ? AppColors.white : AppColors.black,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          _getPaymentText(method.type),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),

          // Selected Card Details
          if (selectedPaymentMethod.type == 'card')
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.textInputBackground,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.gray.withOpacity(0.2),
                  width: 1.w,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.credit_card, size: 20.sp, color: AppColors.gray),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      '${selectedPaymentMethod.cardType} ${selectedPaymentMethod.cardNumber}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onEditCard,
                    child: Icon(
                      Icons.edit_outlined,
                      size: 18.sp,
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  IconData _getPaymentIcon(String type) {
    switch (type) {
      case 'card':
        return Icons.credit_card;
      case 'cash':
        return Icons.money;
      case 'apple_pay':
        return Icons.apple;
      default:
        return Icons.payment;
    }
  }

  String _getPaymentText(String type) {
    switch (type) {
      case 'card':
        return 'Card';
      case 'cash':
        return 'Cash';
      case 'apple_pay':
        return 'Pay';
      default:
        return 'Other';
    }
  }
}
