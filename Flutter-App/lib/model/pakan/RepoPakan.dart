import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:naturefarm/model/pakan/pakan.dart';

class RepoPakan {
  static const String baseUrl =
      'http://10.0.2.2:8000/api/admin'; // API untuk emulator
  // 'http://127.0.0.1:8000/api/admin'; // API untuk web
  // 'http://18.138.155.224/api/admin'; // API untuk AWS

  Future<List<Pakan>> getPakanList() async {
    final response = await http.get(Uri.parse('$baseUrl/pakans'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> items = data['data'];
      return items.map((json) => Pakan.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load pakan list. Status code: ${response.statusCode}');
    }
  }

  Future<Pakan> getPakanDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/pakans/$id'));

    if (response.statusCode == 200) {
      return Pakan.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception(
          'Failed to load pakan detail. Status code: ${response.statusCode}');
    }
  }
}
