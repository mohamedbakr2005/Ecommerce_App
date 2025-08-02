import 'package:e_commerce/core/components/app_text_form_field.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/Search/cubit/search_cubit.dart';
import 'package:e_commerce/views/Search/cubit/search_state.dart';
import 'package:e_commerce/views/Search/widgets/no_results_widget.dart';
import 'package:e_commerce/views/Search/widgets/recent_search_item.dart';
import 'package:e_commerce/views/Search/widgets/search_result_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => SearchCubit(),
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return SafeArea(
                child: Column(
                  children: [
                    // Header
                    _buildHeader(context),

                    // Search Bar
                    _buildSearchBar(context, state),

                    // Content
                    Expanded(child: _buildContent(context, state)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        children: [
          // Title
          Expanded(
            child: Text(
              "Search",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Notification Button
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
            icon: Icon(
              Icons.notifications_outlined,
              size: 24.sp,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, SearchState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AppTextFormField(
        hintText: "Search for clothes...",
        controller: state.searchController,
        onChanged: (value) {
          context.read<SearchCubit>().onSearchChanged(value);
        },
        prefixIcon: Icon(Icons.search, size: 20.sp, color: AppColors.gray),
        suffixIcon: Icon(Icons.mic, size: 20.sp, color: AppColors.gray),
        onTap: () {
          context.read<SearchCubit>().onSearchChanged(
            state.searchController.text,
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, SearchState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.hasSearched) {
      if (state.searchResults.isEmpty) {
        return NoResultsWidget(query: state.currentQuery);
      } else {
        return _buildSearchResults(context, state);
      }
    } else {
      return _buildRecentSearches(context, state);
    }
  }

  Widget _buildRecentSearches(BuildContext context, SearchState state) {
    if (state.recentSearches.isEmpty) {
      return const Center(child: Text('No recent searches'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Recent Searches Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Searches",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<SearchCubit>().clearAllRecentSearches();
                },
                child: Text(
                  "Clear all",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Recent Searches List
        Expanded(
          child: ListView.builder(
            itemCount: state.recentSearches.length,
            itemBuilder: (context, index) {
              final searchTerm = state.recentSearches[index];
              return RecentSearchItem(
                searchTerm: searchTerm,
                onTap: () {
                  context.read<SearchCubit>().onRecentSearchTap(searchTerm);
                },
                onRemove: () {
                  context.read<SearchCubit>().removeRecentSearch(searchTerm);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults(BuildContext context, SearchState state) {
    return ListView.builder(
      itemCount: state.searchResults.length,
      itemBuilder: (context, index) {
        final product = state.searchResults[index];
        return SearchResultItem(
          product: product,
          onTap: () {
            // Navigate to product details
            Navigator.pushNamed(
              context,
              AppRoutes.productDetails,
              arguments: product,
            );
          },
        );
      },
    );
  }
}
