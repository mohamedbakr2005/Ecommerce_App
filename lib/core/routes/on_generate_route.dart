import 'package:e_commerce/core/routes/unknown_page.dart';
import 'package:e_commerce/views/onBoarding/onBoarding_page.dart';
import 'package:flutter/cupertino.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.introLogin:
        return CupertinoPageRoute(builder: (_) => const Placeholder());
      case AppRoutes.onboarding:
        return CupertinoPageRoute(builder: (_) => const OnBoardingPage());

      default:
        return errorRoute();
    }
  }

  static Route? errorRoute() =>
      CupertinoPageRoute(builder: (_) => const UnknownPage());
}
