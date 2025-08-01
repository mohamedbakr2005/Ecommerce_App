import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/verification_code_cubit.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/verification_code_state.dart';
import 'package:e_commerce/views/ForgotPassword/Widgets/verification_code_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationCodeScreen extends StatelessWidget {
  final String email;
  
  const VerificationCodeScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationCodeCubit(email: email),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: BlocBuilder<VerificationCodeCubit, VerificationCodeState>(
            builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.black,
                          size: 24.sp,
                        ),
                      ),
                      verticalSpace(20),
                      
                      // Title
                      Text(
                        "Enter 6 Digit Code",
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      verticalSpace(16),
                      
                      // Description text
                      Text(
                        "Enter 6 digit code that your receive on your email",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray,
                        ),
                      ),
                      verticalSpace(8),
                      Text(
                        "(${state.email})",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray,
                        ),
                      ),
                      verticalSpace(40),
                      
                      // Verification Code Form
                      VerificationCodeForm(state: state),
                      
                      const Spacer(),
                      verticalSpace(20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
