import 'package:e_commerce/core/components/app_text_form_field.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/Home/cubit/home_cubit.dart';
import 'package:e_commerce/views/Home/cubit/home_state.dart';
import 'package:e_commerce/views/Home/widgets/product_card.dart';
import 'package:e_commerce/views/Filters/filters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => HomeCubit(),
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return SafeArea(
                child: Column(
                  children: [
                    // Top Bar
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discover",
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Navigate to notifications
                              Navigator.pushNamed(
                                context,
                                AppRoutes.notifications,
                              );
                            },
                            icon: Icon(
                              Icons.notifications_outlined,
                              size: 24.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Search and Filter Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          // Search Bar
                          Expanded(
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.w),
                                border: Border.all(
                                  color: AppColors.gray.withOpacity(0.3),
                                ),
                              ),
                              child: AppTextFormField(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.search,
                                  );
                                },
                                readOnly: true,
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search),
                                controller: state.searchController,
                                onChanged: (value) {
                                  context.read<HomeCubit>().onSearchChanged(
                                    value,
                                  );
                                },
                              ),
                            ),
                          ),
                          horizontalSpace(12),

                          // Filter Button
                          Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(12.w),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _showFiltersModal(context, state);
                              },
                              icon: Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    verticalSpace(20),

                    // Categories
                    SizedBox(
                      height: 40.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          final isSelected = category == state.selectedCategory;

                          return Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: GestureDetector(
                              onTap: () => context
                                  .read<HomeCubit>()
                                  .selectCategory(category),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.black
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(5.w),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.black
                                        : AppColors.gray.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    verticalSpace(20),

                    // Products Grid
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 15.h,
                                mainAxisExtent: 245.h,
                              ),
                          itemCount: context
                              .read<HomeCubit>()
                              .filteredProducts
                              .length,
                          itemBuilder: (context, index) {
                            final product = context
                                .read<HomeCubit>()
                                .filteredProducts[index];
                            return ProductCard(product: product);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showFiltersModal(BuildContext context, HomeState state) {
    final homeCubit = context.read<HomeCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => FiltersScreen(
          homeCubit: homeCubit,
          currentFilters: {
            'sortBy': state.sortBy,
            'priceRange': state.priceRange,
            'size': state.selectedSize,
          },
          onApplyFilters: (filters) {
            homeCubit.applyFilters(filters);
          },
        ),
      ),
    );
  }
}
