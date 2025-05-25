import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:naturefarm/model/artikel/artikel.dart';

class ApiService {
  // static const String baseUrl =
  //     'http://10.0.2.2:8000/api/admin'; // API untuk emulator
  static const String baseUrl =
      'http://127.0.0.1:8000/api/admin'; // API untuk web
  // static const String baseUrl =
  //     'http://18.138.155.224/api/admin'; // API untuk AWS

  Future<List<Article>> getArticles() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/artikels'));

      if (response.statusCode == 200) {
        // Parse response body
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Akses array data dari response
        List<dynamic> data = jsonResponse['data'];

        // Convert ke list Article
        List<Article> articles =
            data.map((item) => Article.fromJson(item)).toList();

        return articles;
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting articles: $e');
    }
  }

  Future<Article> getArticleDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/artikels/$id'));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return Article.fromJson(jsonResponse['data']);
      } else {
        throw Exception(
            'Failed to load article details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting article detail: $e');
    }
  }
}
