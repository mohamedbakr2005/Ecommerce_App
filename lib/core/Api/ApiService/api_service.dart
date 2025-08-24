import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://9ebcbc480f7d21add5fd6558850b6e4c.serveo.net/api";

  // ssh -R 80:localhost:5253 serveo.net

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error: ${response.statusCode} - ${response.body}");
    }
  }
}
