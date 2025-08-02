import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/Checkout/cubit/checkout_cubit.dart';
import 'package:e_commerce/views/Checkout/cubit/checkout_state.dart';
import 'package:e_commerce/views/Checkout/widgets/delivery_address_widget.dart';
import 'package:e_commerce/views/Checkout/widgets/payment_method_widget.dart';
import 'package:e_commerce/views/Checkout/widgets/order_summary_widget.dart';
import 'package:e_commerce/views/Checkout/widgets/promo_code_widget.dart';
import 'package:e_commerce/views/Checkout/widgets/place_order_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.red,
                ),
              );
            }

            if (state is OrderPlacedSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Order placed successfully! Order ID: ${state.orderId}',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              // Navigate to success screen or back to home
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            }
          },
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
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: 24.sp,
              color: AppColors.black,
            ),
          ),

          // Title
          Expanded(
            child: Center(
              child: Text(
                "Checkout",
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

  Widget _buildContent(BuildContext context, CheckoutState state) {
    if (state is CheckoutLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state is CheckoutError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60.sp, color: AppColors.red),
            verticalSpace(16),
            Text(
              "Error loading checkout",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            verticalSpace(8),
            Text(
              state.message,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.gray,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(24),
            ElevatedButton(
              onPressed: () {
                context.read<CheckoutCubit>().loadCheckoutData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Retry',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
    }

    if (state is CheckoutLoaded) {
      return Column(
        children: [
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Delivery Address
                  DeliveryAddressWidget(
                    deliveryAddress: state.checkoutData.deliveryAddress,
                    onChangeAddress: () async {
                      final selectedAddress = await Navigator.pushNamed(
                        context,
                        AppRoutes.address,
                      );
                      if (selectedAddress != null) {
                        // Update the delivery address in the checkout
                        // This would typically update the cubit state
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Address updated successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                  ),

                  // Payment Method
                  PaymentMethodWidget(
                    availablePaymentMethods:
                        state.checkoutData.availablePaymentMethods,
                    selectedPaymentMethod:
                        state.checkoutData.selectedPaymentMethod,
                    onPaymentMethodSelected: (paymentMethodId) {
                      context.read<CheckoutCubit>().selectPaymentMethod(
                        paymentMethodId,
                      );
                    },
                    onEditCard: () {
                      // TODO: Navigate to card management screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Card management feature coming soon!'),
                        ),
                      );
                    },
                  ),

                  // Order Summary
                  OrderSummaryWidget(
                    orderSummary: state.checkoutData.orderSummary,
                  ),

                  // Promo Code
                  PromoCodeWidget(
                    currentPromoCode: state.promoCode,
                    isPromoCodeApplied: state.isPromoCodeApplied,
                    onApplyPromoCode: (promoCode) {
                      context.read<CheckoutCubit>().applyPromoCode(promoCode);
                    },
                    onRemovePromoCode: () {
                      context.read<CheckoutCubit>().removePromoCode();
                    },
                  ),

                  // Bottom spacing for button
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),

          // Place Order Button
          PlaceOrderButton(
            isLoading: state.isProcessingOrder,
            onPlaceOrder: () {
              context.read<CheckoutCubit>().placeOrder();
            },
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
