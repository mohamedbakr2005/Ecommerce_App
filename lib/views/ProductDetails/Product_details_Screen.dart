import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/ProductDetails/cubit/product_details_cubit.dart';
import 'package:e_commerce/views/ProductDetails/cubit/product_details_state.dart';
import 'package:e_commerce/views/ProductDetails/widgets/add_to_cart_button.dart';
import 'package:e_commerce/views/ProductDetails/widgets/color_selector.dart';
import 'package:e_commerce/views/ProductDetails/widgets/size_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Load product details when screen initializes
    context.read<ProductDetailsCubit>().loadProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: _buildAppBar(),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.black),
            );
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.error!,
                    style: TextStyle(fontSize: 16.sp, color: AppColors.red),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductDetailsCubit>().loadProductDetails(
                        widget.productId,
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.product == null) {
            return const Center(child: Text('Product not found'));
          }

          return _buildProductDetails(state);
        },
      ),
      bottomNavigationBar: const AddToCartButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.scaffoldBackground,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
      ),
      title: Text(
        'Details',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      centerTitle: true,
      actions: [
        BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                context.read<ProductDetailsCubit>().toggleFavorite();
              },
              icon: Icon(
                state.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: state.isFavorite ? AppColors.red : AppColors.black,
              ),
            );
          },
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.notifications);
          },
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.black,
          ),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  Widget _buildProductDetails(ProductDetailsState state) {
    final product = state.product!;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            height: 300.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.w),
              child: Image.asset(product.image, fit: BoxFit.cover),
            ),
          ),

          SizedBox(height: 24.h),

          // Product Name
          Text(
            product.name,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),

          SizedBox(height: 8.h),

          // Rating
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20.sp),
              SizedBox(width: 4.w),
              Text(
                '${product.rating}/5',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '(${product.reviewCount} reviews)',
                style: TextStyle(fontSize: 14.sp, color: AppColors.gray),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Description
          Text(
            product.description,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.gray,
              height: 1.5,
            ),
          ),

          SizedBox(height: 24.h),

          // Size Selector
          const SizeSelector(),

          SizedBox(height: 24.h),

          // Color Selector
          const ColorSelector(),

          SizedBox(height: 100.h), // Space for bottom button
        ],
      ),
    );
  }
}
