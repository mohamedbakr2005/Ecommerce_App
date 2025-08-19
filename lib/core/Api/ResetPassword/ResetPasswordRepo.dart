import 'dart:convert';
import 'package:e_commerce/core/Api/ApiService/api_service.dart';
import 'package:http/http.dart' as http;

class Resetpasswordrepo {
  Future<bool> sendResetCode(String email) async {
    final url = Uri.parse('${ApiService.baseUrl}/auth/send-reset-code');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    return response.statusCode == 200;
  }

  Future<bool> verifyResetCode(String email, String code) async {
    final url = Uri.parse('${ApiService.baseUrl}/auth/verify-reset-code');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "code": code}),
    );

    return response.statusCode == 200;
  }

  Future<bool> resetPasswordWithCode(
    String email,
    String code,
    String newPassword,
  ) async {
    final url = Uri.parse(
      '${ApiService.baseUrl}/auth/reset-password-with-code',
    );
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "code": code,
        "newPassword": newPassword,
      }),
    );

    return response.statusCode == 200;
  }
}
