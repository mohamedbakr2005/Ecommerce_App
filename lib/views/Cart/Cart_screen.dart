import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/Cart/cubit/cart_cubit.dart';
import 'package:e_commerce/views/Cart/cubit/cart_state.dart';
import 'package:e_commerce/views/Cart/widgets/cart_item_card.dart';
import 'package:e_commerce/views/Cart/widgets/empty_cart_widget.dart';
import 'package:e_commerce/views/Cart/widgets/order_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  // Header
                  _buildHeader(context),

                  // Content
                  Expanded(child: _buildContent(context, state)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.gray.withOpacity(0.2),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        children: [
          // Title
          Expanded(
            child: Center(
              child: Text(
                "My Cart",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
          ),

          // Notification Icon
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
            child: Icon(
              Icons.notifications_outlined,
              size: 24.sp,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, CartState state) {
    if (state is CartLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state is CartError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
            verticalSpace(16),
            Text(
              "Error loading cart",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            verticalSpace(8),
            Text(
              state.message,
              style: TextStyle(fontSize: 14.sp, color: AppColors.gray),
              textAlign: TextAlign.center,
            ),
            verticalSpace(20),
            ElevatedButton(
              onPressed: () => context.read<CartCubit>().loadCart(),
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    if (state is CartLoaded) {
      if (state.items.isEmpty) {
        // Empty Cart State
        return const EmptyCartWidget();
      } else {
        // Filled Cart State
        return Column(
          children: [
            // Cart Items List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return CartItemCard(item: state.items[index]);
                },
              ),
            ),

            // Order Summary
            const OrderSummaryWidget(),
          ],
        );
      }
    }

    // Initial state
    return const Center(child: CircularProgressIndicator());
  }
}
