import 'package:e_commerce/views/Account/cubit/account_cubit.dart';
import 'package:e_commerce/views/Account/cubit/account_state.dart';
import 'package:e_commerce/views/Account/widgets/build_account_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountCubit(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Account',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
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
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    BuildAccountOption(
                      icon: Icons.inventory_2_outlined,
                      title: 'My Orders',
                      onTap: () {
                        context.read<AccountCubit>().navigateToOrders(context);
                      },
                    ),
                    BuildAccountOption(
                      icon: Icons.person_outline,
                      title: 'My Details',
                      onTap: () {
                        context.read<AccountCubit>().navigateToDetails(context);
                      },
                    ),
                    BuildAccountOption(
                      icon: Icons.home_outlined,
                      title: 'Address Book',
                      onTap: () {
                        context.read<AccountCubit>().navigateToAddressBook();
                      },
                    ),
                    BuildAccountOption(
                      icon: Icons.credit_card_outlined,
                      title: 'Payment Methods',
                      onTap: () {
                        context.read<AccountCubit>().navigateToPaymentMethods();
                      },
                    ),
                    BuildAccountOption(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      onTap: () {
                        context.read<AccountCubit>().navigateToNotifications();
                      },
                    ),
                    const SizedBox(height: 16),
                    BuildAccountOption(
                      icon: Icons.help_outline,
                      title: 'FAQs',
                      onTap: () {
                        context.read<AccountCubit>().navigateToFAQs();
                      },
                    ),
                    BuildAccountOption(
                      icon: Icons.headset_mic_outlined,
                      title: 'Help Center',
                      onTap: () {
                        context.read<AccountCubit>().navigateToHelpCenter();
                      },
                    ),
                    const SizedBox(height: 16),
                    BuildAccountOption(
                      icon: Icons.logout,
                      title: 'Logout',
                      isLogout: true,
                      onTap: () {
                        context.read<AccountCubit>().logout(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
