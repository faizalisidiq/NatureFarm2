import 'package:flutter/material.dart';
import 'package:naturefarm/pages/login_page.dart'; // Ganti ini sesuai nama file loginmu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(), // Arahkan ke LoginPage
    );
  }
}
