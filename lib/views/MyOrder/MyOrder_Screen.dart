import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_icons.dart';
import 'package:e_commerce/core/constants/app_images.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/MyOrder/cubit/order_cubit.dart';
import 'package:e_commerce/views/MyOrder/cubit/order_state.dart';
import 'package:e_commerce/views/MyOrder/widget/time_line.dart';
import 'package:e_commerce/views/MyOrder/widget/track_order_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOrdersScreen extends StatelessWidget {
  void _showTrackOrder(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: TrackOrderForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersCubit(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(
            "My Orders",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          ],
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            final cubit = context.read<OrdersCubit>();
            final orders = state.selectedTab == OrderStatus.ongoing
                ? state.ongoingOrders
                : state.completedOrders;

            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    color: AppColors.gray.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => cubit.changeTab(OrderStatus.ongoing),
                          child: Container(
                            decoration: BoxDecoration(
                              color: state.selectedTab == OrderStatus.ongoing
                                  ? AppColors.white
                                  : AppColors.gray.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                "Ongoing",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      state.selectedTab == OrderStatus.ongoing
                                      ? AppColors.primary
                                      : AppColors.placeholder,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => cubit.changeTab(OrderStatus.completed),
                          child: Container(
                            decoration: BoxDecoration(
                              color: state.selectedTab == OrderStatus.completed
                                  ? AppColors.white
                                  : AppColors.gray.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            padding: EdgeInsets.all(16),

                            child: Center(
                              child: Text(
                                "Completed",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      state.selectedTab == OrderStatus.completed
                                      ? AppColors.primary
                                      : AppColors.placeholder,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: orders.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppIcons.emptyOrder,
                                width: 100.w,
                                height: 100.h,
                              ),
                              SizedBox(height: 16),
                              Text(
                                state.selectedTab == OrderStatus.ongoing
                                    ? "No Ongoing Orders!"
                                    : "No Completed Orders!",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "You don’t have any ${state.selectedTab == OrderStatus.ongoing ? "ongoing" : "completed"} orders\nat this time.",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppColors.placeholder,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final order = orders[index];
                            return Container(
                              height: 130.h,
                              margin: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 20.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // spacing: 15.w,
                                children: [
                                  Image.asset(
                                    state.selectedTab == OrderStatus.ongoing
                                        ? order.imageUrl ?? AppImages.home1
                                        : order.imageUrl ?? AppImages.home1,

                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.22,
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                    fit: BoxFit.cover,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,

                                            children: [
                                              Text(
                                                order.name,
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.035,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Size ${order.size}",
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.035,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.23,
                                            margin: EdgeInsets.only(left: 10.w),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 4.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.placeholder
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              order.status,
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 12.sp,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                      verticalSpace(5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$${order.price.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.035,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          horizontalSpace(50),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.05,
                                                vertical:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.02,
                                              ),
                                              backgroundColor:
                                                  AppColors.primary,
                                              foregroundColor: Colors.white,
                                            ),
                                            onPressed: () {
                                              if (order.action ==
                                                  "Track Order") {
                                                _showTrackOrder(context);
                                              }
                                            },
                                            child: Text(
                                              order.action,
                                              style: TextStyle(
                                                fontSize:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.03,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
