import 'package:flutter/material.dart';
import 'package:naturefarm/model/keranjang/KeranjangProvider.dart';
import 'package:provider/provider.dart';
import 'package:naturefarm/pages/login_page.dart'; // Ganti ini sesuai nama file loginmu

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KeranjangProvider()),
        // Provider lainnya jika ada
      ],
      child: const MyApp(),
    ),
  );
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
