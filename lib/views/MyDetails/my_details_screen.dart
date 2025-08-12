import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/views/MyDetails/cubit/my_details_cubit.dart';
import 'package:e_commerce/views/MyDetails/cubit/my_details_state.dart';
import 'package:e_commerce/views/MyDetails/widgets/my_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDetailsScreen extends StatelessWidget {
  MyDetailsScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyDetailsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Details",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          ],
        ),
        body: BlocBuilder<MyDetailsCubit, MyDetailsState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15,
                  ).r,
                  child: MyDetails_form(formKey: formKey, state: state),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
