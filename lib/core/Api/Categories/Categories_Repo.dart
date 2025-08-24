import 'dart:convert';
import 'package:e_commerce/core/Api/ApiService/api_service.dart';
import 'package:http/http.dart' as http;

class CategoryRepo {
  Future<List<String>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/categories'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return List<String>.from(data);
    } else {
      throw Exception(
        'Failed to load categories (status: ${response.statusCode})',
      );
    }
  }

  
}
