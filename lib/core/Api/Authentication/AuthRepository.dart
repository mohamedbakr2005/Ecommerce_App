import 'dart:convert';

import 'package:e_commerce/core/Api/ApiService/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> signup(
    String name,
    String email,
    String password,
  ) async {
    return await _apiService.post("auth/register", {
      "username": name,
      "email": email,
      "password": password,
    });
  }

  Future<bool> signin(String email, String password) async {
    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("accessToken", body["accessToken"]);
      await prefs.setString("refreshToken", body["refreshToken"]);

      final expiry = DateTime.now().add(Duration(days: 7));
      await prefs.setString("expiry", expiry.toIso8601String());

      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    final prefs = AuthRepository();
    final token = await prefs.getToken();

    if (token == null) {
      return false;
    }

    final url = Uri.parse("${ApiService.baseUrl}/auth/logout");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      await prefs.clearToken();
      return true;
    } else {
      print("Logout failed: ${response.body}");
      return false;
    }
  }

  Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryString = prefs.getString("expiry");

    if (expiryString == null) return true;

    final expiry = DateTime.parse(expiryString);
    return DateTime.now().isAfter(expiry);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("accessToken");
    return token != null && token.isNotEmpty;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("accessToken");
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("accessToken");
  }

  
}
