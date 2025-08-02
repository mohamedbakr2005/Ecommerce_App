import 'package:e_commerce/core/routes/unknown_page.dart';
import 'package:e_commerce/views/LogIn/LogIn_screen.dart';
import 'package:e_commerce/views/Reviews/Reviews_screen.dart';
import 'package:e_commerce/views/SignUp/sign_up_screen.dart';
import 'package:e_commerce/views/onBoarding/onBoarding_page.dart';
import 'package:e_commerce/views/ForgotPassword/Forgot_password_screen.dart';
import 'package:e_commerce/views/ForgotPassword/verification_code_screen.dart';
import 'package:e_commerce/views/ForgotPassword/reset_password_screen.dart';
import 'package:e_commerce/views/ForgotPassword/password_reset_success_screen.dart';
import 'package:e_commerce/views/Home/Home_Screen.dart';
import 'package:e_commerce/views/init/init_screen.dart';
import 'package:e_commerce/views/Notification/notification_screen.dart';
import 'package:e_commerce/views/Search/search_screen.dart';
import 'package:e_commerce/views/SavedItems/Saved_items_screen.dart';
import 'package:e_commerce/views/SavedItems/cubit/saved_items_cubit.dart';
import 'package:e_commerce/views/ProductDetails/Product_details_Screen.dart';
import 'package:e_commerce/views/ProductDetails/cubit/product_details_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/views/Notification/cubit/notification_cubit.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.onboarding:
        return CupertinoPageRoute(builder: (_) => const OnBoardingPage());
      case AppRoutes.signup:
        return CupertinoPageRoute(builder: (_) => SignUpScreen());
      case AppRoutes.login:
        return CupertinoPageRoute(builder: (_) => LogInScreen());
      case AppRoutes.forgotPassword:
        return CupertinoPageRoute(builder: (_) => const ForgotPasswordScreen());
      case AppRoutes.verification:
        final String email = settings.arguments as String;
        return CupertinoPageRoute(
          builder: (_) => VerificationCodeScreen(email: email),
        );
      case AppRoutes.passwordReset:
        return CupertinoPageRoute(builder: (_) => const ResetPasswordScreen());
      case AppRoutes.passwordResetSuccess:
        return CupertinoPageRoute(
          builder: (_) => const PasswordResetSuccessScreen(),
        );
      case AppRoutes.home:
        return CupertinoPageRoute(builder: (_) => const InitScreen());
      case AppRoutes.notifications:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => NotificationCubit(),
            child: const NotificationScreen(),
          ),
        );
      case AppRoutes.search:
        return CupertinoPageRoute(builder: (_) => const SearchScreen());
      case AppRoutes.savedItems:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SavedItemsCubit(),
            child: const SavedItemsScreen(),
          ),
        );
      case AppRoutes.productDetails:
        final String productId = settings.arguments as String;
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProductDetailsCubit(),
            child: ProductDetailsScreen(productId: productId),
          ),
        );
      case AppRoutes.reviews:
        return CupertinoPageRoute(builder: (_) => const ReviewsScreen());
      default:
        return errorRoute();
    }
  }

  static Route? errorRoute() =>
      CupertinoPageRoute(builder: (_) => const UnknownPage());
}
