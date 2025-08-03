import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/views/NewCard/widgets/new_card_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce/views/NewCard/cubit/new_card_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCardScreen extends StatelessWidget {
  NewCardScreen({super.key});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewCardCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'New Card',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.notifications);
                },
              ),
            ],
          ),
          body: BlocBuilder<NewCardCubit, NewCardState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: NewCardForm(
                  formKey: formKey,
                  state: state,
                  onPressed: () {
                    _showCvcHelpDialog(context);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showCvcHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.scaffoldBackground,
          title: Text(
            'Where to find CVC?',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'The CVC (Card Verification Code) is a 3-digit security code found on the back of your card, usually near the signature panel.',
            style: TextStyle(fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
