import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/components/app_text_form_field.dart';
import 'package:e_commerce/core/components/app_button.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/NewCard/cubit/new_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewCardForm extends StatelessWidget {
  const NewCardForm({
    super.key,
    required this.formKey,
    required this.state,
    required this.onPressed,
  });

  final GlobalKey<FormState> formKey;
  final NewCardState state;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            'Add Debit or Credit Card',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(30),
          Text(
            'Card number',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          verticalSpace(8),
          AppTextFormField(
            maxLength: 16,
            hintText: 'Enter your card number',
            controller: state.cardNumberController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter card number';
              }
              if (value.length < 16) {
                return 'Card number must be 16 digits';
              }
              return null;
            },
          ),
          verticalSpace(20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiry Date',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpace(8),
                    AppTextFormField(
                      maxLength: 5,
                      hintText: 'MM/YY',
                      controller: state.expiryDateController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter expiry date';
                        }
                        if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                          return 'Use MM/YY format';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Security Code',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpace(8),
                    AppTextFormField(
                      maxLength: 3,
                      hintText: 'CVC',
                      controller: state.securityCodeController,
                      keyboardType: TextInputType.number,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.help_outline,
                          color: AppColors.gray,
                          size: 20.sp,
                        ),
                        onPressed: onPressed,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter CVC';
                        }
                        if (value.length < 3) {
                          return 'CVC must be 3 digits';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          state.isLoading
              ? Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : AppButton(
                  text: 'Add Card',
                  onPressed: state.isFormValid
                      ? () => context.read<NewCardCubit>().addCard(context)
                      : null,
                  backgroundColor: state.isFormValid
                      ? AppColors.primary
                      : AppColors.gray,
                ),
          verticalSpace(20),
        ],
      ),
    );
  }
}
