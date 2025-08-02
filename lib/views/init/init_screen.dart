import 'package:e_commerce/views/Cart/Cart_screen.dart';
import 'package:e_commerce/views/Cart/cubit/cart_cubit.dart';
import 'package:e_commerce/views/Home/Home_Screen.dart';
import 'package:e_commerce/views/SavedItems/Saved_items_screen.dart';
import 'package:e_commerce/views/SavedItems/cubit/saved_items_cubit.dart';
import 'package:e_commerce/views/Search/search_screen.dart';
import 'package:e_commerce/views/init/cubit/bottom_nav_cubit.dart';
import 'package:e_commerce/views/init/cubit/bottom_nav_state.dart';
import 'package:e_commerce/views/init/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(state.currentIndex),
            bottomNavigationBar: const BottomNavBar(),
          );
        },
      ),
    );
  }

  Widget _buildBody(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SearchScreen();
      case 2:
        return BlocProvider(
          create: (context) => SavedItemsCubit(),
          child: const SavedItemsScreen(),
        );
      case 3:
        return BlocProvider(
          create: (context) => CartCubit(),
          child: const CartScreen(),
        );
      case 4:
        return _buildAccountScreen();
      default:
        return const HomeScreen();
    }
  }

  Widget _buildAccountScreen() {
    return const Scaffold(
      body: Center(
        child: Text(
          'Account Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
