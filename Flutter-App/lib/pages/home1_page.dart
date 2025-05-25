import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naturefarm/pages/artikel/artikel_page.dart';
import 'package:naturefarm/pages/hewan/mart.dart';
import 'package:naturefarm/pages/pakan/PakanPage.dart';
import 'shipping_page.dart';
import 'lokasi/flutter_map.dart'; // Impor FlutterMapPage
import 'profile_page.dart'; // Import halaman profil yang baru dibuat
import 'package:naturefarm/pages/notification_page.dart'; // tambahkan ini

class Home1Page extends StatefulWidget {
  const Home1Page({super.key});

  @override
  State<Home1Page> createState() => _Home1PageState();
}

class _Home1PageState extends State<Home1Page> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EEEE),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                // Header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF224D31), // Warna hijau header
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo atau judul aplikasi
                      Text(
                        'NatureFarm',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Icon profil
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Color(0xFF224D31)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Konten scrollable
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        // GridView yang lebih kecil ukurannya
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children: [
                            _buildFiturItem(Icons.article, 'Artikel',
                                onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleListScreen(),
                                ),
                              );
                            }),
                            _buildFiturItem(Icons.shopping_basket, 'Mart',
                                onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HewanPage(),
                                ),
                              );
                            }),
                            _buildFiturItem(Icons.agriculture, 'Info Pakan',
                                onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PakanListScreen(),
                                ),
                              );
                            }),
                            _buildFiturItem(Icons.location_on, 'Lokasi',
                                onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FlutterMapPage(),
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFiturItem(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(2),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 55, color: const Color(0xFF224D31)),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF224D31),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
