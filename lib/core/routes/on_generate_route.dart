import 'package:e_commerce/core/routes/unknown_page.dart';
import 'package:e_commerce/views/LogIn/LogIn_screen.dart';
import 'package:e_commerce/views/SignUp/sign_up_screen.dart';
import 'package:e_commerce/views/onBoarding/onBoarding_page.dart';
import 'package:flutter/cupertino.dart';

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
      default:
        return errorRoute();
    }
  }

  static Route? errorRoute() =>
      CupertinoPageRoute(builder: (_) => const UnknownPage());
}
