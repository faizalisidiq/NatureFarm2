import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:naturefarm/model/hewan/hewan.dart';

class RepoHewan {
  final String apiUrl =
      'http://10.0.2.2:8000/api/admin/hewans'; // Gantilah dengan URL API Anda
      // 'http://127.0.0.1:8000/api/admin/hewans'; // API untuk web
  Future<List<Hewan>> getData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['data'] != null) {
          List<Hewan> hewanList = [];
          for (var hewan in responseData['data']) {
            hewanList.add(Hewan.fromJson(hewan));
          }
          return hewanList; // Mengembalikan lebih dari satu item
        } else {
          throw Exception('No data found');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
