import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/Reviews/cubit/reviews_cubit.dart';
import 'package:e_commerce/views/Reviews/cubit/reviews_state.dart';
import 'package:e_commerce/views/Reviews/widgets/rating_breakdown.dart';
import 'package:e_commerce/views/Reviews/widgets/review_item.dart';
import 'package:e_commerce/views/Reviews/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewsCubit(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: 20.sp,
            ),
          ),
          title: Text(
            'Reviews',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                // Navigate to notifications
              },
              icon: Icon(
                Icons.notifications_outlined,
                color: AppColors.black,
                size: 20.sp,
              ),
            ),
          ],
        ),
        body: BlocBuilder<ReviewsCubit, ReviewsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.black),
              );
            }

            if (state.errorMessage.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48.sp,
                      color: AppColors.red,
                    ),
                    verticalSpace(16),
                    Text(
                      state.errorMessage,
                      style: TextStyle(fontSize: 16.sp, color: AppColors.red),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ReviewsCubit>().loadReviews();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overall Rating Section
                  _buildOverallRatingSection(state),
                  verticalSpace(24),

                  // Rating Breakdown Section
                  _buildRatingBreakdownSection(state),
                  verticalSpace(24),

                  // Reviews Section
                  _buildReviewsSection(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverallRatingSection(ReviewsState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          // Average Rating
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.ratingBreakdown.averageRating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              verticalSpace(8),
              StarRating(
                rating: state.ratingBreakdown.averageRating,
                size: 20,
                filledColor: Colors.amber,
                unfilledColor: Colors.grey.shade300,
              ),
              verticalSpace(4),
              Text(
                '${state.ratingBreakdown.totalRatings} Ratings',
                style: TextStyle(fontSize: 14.sp, color: AppColors.gray),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBreakdownSection(ReviewsState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rating Breakdown',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          verticalSpace(16),
          RatingBreakdownWidget(ratingBreakdown: state.ratingBreakdown),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(BuildContext context, ReviewsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Reviews Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${state.reviews.length} Reviews',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              // Sort Dropdown
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: state.selectedSortOption,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 16.sp,
                      color: AppColors.gray,
                    ),
                    style: TextStyle(fontSize: 14.sp, color: AppColors.black),
                    items: state.sortOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        context.read<ReviewsCubit>().changeSortOption(newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(16),

        // Reviews List
        ...state.reviews.map((review) => ReviewItem(review: review)),
      ],
    );
  }
}
