import 'package:e_commerce/core/Api/Authentication/AuthRepository.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthRepository _authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    _checkLogin();
    isLoggedIn();
  }

  void _checkLogin() async {
    bool loggedIn = await _authRepository.isLoggedIn();
    if (loggedIn) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("accessToken");

    if (token == null || token.isEmpty) return false;

    final expired = await isTokenExpired();
    if (expired) {
      await Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
      return false;
    }

    return true;
  }

  Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryString = prefs.getString("expiry");

    if (expiryString == null) return true;

    final expiry = DateTime.parse(expiryString);
    return DateTime.now().isAfter(expiry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: AppColors.black)),
    );
  }
}
