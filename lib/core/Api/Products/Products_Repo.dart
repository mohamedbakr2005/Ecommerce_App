import 'dart:convert';

import 'package:e_commerce/core/Api/ApiService/api_service.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/products'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
