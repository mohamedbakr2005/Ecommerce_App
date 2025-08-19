import 'package:e_commerce/core/components/app_button.dart';
import 'package:e_commerce/core/components/app_text_form_field.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/core/utils/validators.dart';
import 'package:e_commerce/views/MyDetails/cubit/my_details_cubit.dart';
import 'package:e_commerce/views/MyDetails/cubit/my_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDetails_form extends StatelessWidget {
  const MyDetails_form({super.key, required this.formKey, required this.state});
  final GlobalKey<FormState> formKey;
  final MyDetailsState state;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Full Name",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          verticalSpace(5),
          AppTextFormField(
            controller: state.fullname,
            hintText: "Enter your full name",
            validator: Validators.required.call,
          ),
          verticalSpace(15),
          Text(
            "Email Address",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          verticalSpace(5),
          AppTextFormField(
            controller: state.email,
            hintText: "Enter your email address",
            validator: Validators.required.call,
          ),
          verticalSpace(15),
          Text(
            "Date of Birth",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          verticalSpace(5),
          AppTextFormField(
            controller: state.dataOfbirth,
            hintText: "Enter your Date of Birth",
            validator: Validators.required.call,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.date_range_outlined),
            ),
          ),
          verticalSpace(15),
          Text(
            "Gender",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          verticalSpace(5),
          AppTextFormField(
            controller: state.gender,
            hintText: "Select your gender",
            validator: Validators.required.call,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_down_outlined),
            ),
          ),
          verticalSpace(15),
          Text(
            "Phone Number",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          verticalSpace(5),
          AppTextFormField(
            controller: state.phoneNumber,
            hintText: "Enter your Phone Number",
            validator: Validators.required.call,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.date_range_outlined),
            ),
          ),
          verticalSpace(80),
          AppButton(
            onPressed: () {
              context.read<MyDetailsCubit>().myDetails(context);
            },
            text: "Submit",
          ),
        ],
      ),
    );
  }
}
