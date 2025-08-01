import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/verification_code_cubit.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/verification_code_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationCodeForm extends StatelessWidget {
  final VerificationCodeState state;

  const VerificationCodeForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Code input fields
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return SizedBox(
              width: 50.w,
              height: 60.h,
              child: TextFormField(
                controller: state.codeControllers[index],
                focusNode: state.focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                onChanged: (value) => context
                    .read<VerificationCodeCubit>()
                    .onCodeChanged(value, index),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.w),
                    borderSide: BorderSide(color: AppColors.gray, width: 1.w),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.w),
                    borderSide: BorderSide(color: AppColors.gray, width: 1.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.w),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 2.w,
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            );
          }),
        ),
        verticalSpace(30),

        // Resend code option
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Email not received? ",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.gray,
              ),
            ),
            InkWell(
              onTap: state.isLoading
                  ? null
                  : () => context.read<VerificationCodeCubit>().resendCode(
                      context,
                    ),
              child: Text(
                "Resend code",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(40),

        // Continue button
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.w),
              ),
            ),
            onPressed: state.isLoading || !state.isCodeComplete
                ? null
                : () =>
                      context.read<VerificationCodeCubit>().verifyCode(context),
            child: state.isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.w,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.white,
                      ),
                    ),
                  )
                : Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
