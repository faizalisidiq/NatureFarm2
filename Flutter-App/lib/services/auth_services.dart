import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naturefarm/services/globals.dart';

class AuthServices {
  static Future<Map<String, dynamic>> register({
    required String nama,
    required String email,
    required String password,
    required String no_hp,
  }) async {
    try {
      Map data = {
        'nama': nama,
        'email': email,
        'password': password,
        'no_hp': no_hp,
      };

      var body = json.encode(data);
      var url = Uri.parse(baseURL + 'admin/customers');

      http.Response response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Registrasi berhasil',
          'data': json.decode(response.body)
        };
      } else {
        return {
          'success': false,
          'message': 'Registrasi gagal: ${response.statusCode}',
          'data': json.decode(response.body)
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e', 'data': null};
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      var url = Uri.parse(baseURL + 'admin/customers');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var customers = json.decode(response.body);

        // Cek email terlebih dahulu
        var userWithEmail = customers['data'].firstWhere(
            (customer) => customer['email'] == email,
            orElse: () => null);

        if (userWithEmail == null) {
          return {'success': false, 'message': 'email_not_found', 'data': null};
        }

        // Jika email ditemukan, cek password
        if (userWithEmail['password'] != password) {
          return {'success': false, 'message': 'wrong_password', 'data': null};
        }

        // Jika email dan password benar
        return {
          'success': true,
          'message': 'Login berhasil',
          'data': userWithEmail
        };
      } else {
        return {
          'success': false,
          'message': 'Gagal mengambil data: ${response.statusCode}',
          'data': null
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e', 'data': null};
    }
  }
}
