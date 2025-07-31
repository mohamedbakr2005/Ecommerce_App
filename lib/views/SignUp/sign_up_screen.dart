import 'package:e_commerce/core/components/app_button.dart';
import 'package:e_commerce/core/components/app_text_form_field.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_images.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/core/utils/validators.dart';
import 'package:e_commerce/views/SignUp/cubit/SignUp_cubit.dart';
import 'package:e_commerce/views/SignUp/cubit/SignUp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create an account",
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          "Let's create your account",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray,
                          ),
                        ),
                        verticalSpace(20),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Full Name",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                              verticalSpace(5),
                              AppTextFormField(
                                controller: state.fullNameController,
                                hintText: "Enter your full name",
                                validator: Validators.required,
                              ),
                              verticalSpace(20),
                              Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                              verticalSpace(5),
                              AppTextFormField(
                                controller: state.emailController,
                                hintText: "Enter your email",
                                validator: Validators.email,
                              ),
                              verticalSpace(20),
                              Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                              verticalSpace(5),
                              AppTextFormField(
                                controller: state.passwordController,
                                hintText: "Enter your password",
                                obscureText: !state.isPasswordVisible,
                                validator: Validators.password,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context
                                        .read<SignUpCubit>()
                                        .togglePasswordVisibility();
                                  },
                                  icon: Icon(
                                    state.isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                              verticalSpace(10),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "By signing up, you agree to our ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black.withOpacity(0.7),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Terms",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black.withOpacity(0.9),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ", Privacy Policy,",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black.withOpacity(0.9),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black.withOpacity(0.7),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Cookies Use",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black.withOpacity(0.9),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace(20),
                              AppButton(
                                onPressed: state.isFormValid
                                    ? () {
                                        // Handle sign up logic here
                                      }
                                    : null,
                                text: "Sign Up",
                                backgroundColor: state.isFormValid
                                    ? AppColors.primary
                                    : AppColors.gray,
                              ),
                              verticalSpace(20),
                              Row(
                                children: [
                                  Expanded(child: Divider()),
                                  horizontalSpace(10),
                                  Text(
                                    "Or",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.gray,
                                    ),
                                  ),
                                  horizontalSpace(10),
                                  Expanded(child: Divider()),
                                ],
                              ),
                              verticalSpace(20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.w),
                                    side: BorderSide(color: AppColors.gray),
                                  ),
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppImages.google,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                    horizontalSpace(10),
                                    Text(
                                      "Continue with Google",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace(20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.facebook,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.w),
                                    side: BorderSide(color: AppColors.gray),
                                  ),
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppImages.facebook,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                    horizontalSpace(10),
                                    Text(
                                      "Continue with Facebook",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace(40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account? ",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.gray,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRoutes.login,
                                        (route) => false,
                                      );
                                    },
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
