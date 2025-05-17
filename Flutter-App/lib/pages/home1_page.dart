import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'shipping_page.dart';
import 'flutter_map.dart'; // Impor FlutterMapPage
import 'profile_page.dart'; // Import halaman profil yang baru dibuat

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
                      // Username dan status
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usernameee',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Peternak',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      // Icon notifikasi & profil
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: Color(0xFF224D31)),
                          ),
                        ],
                      )
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Fitur',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Color(0xFF224D31),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // GridView yang lebih kecil ukurannya
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children: [
                            _buildFiturItem(Icons.article, 'Artikel'),
                            _buildFiturItem(Icons.shopping_basket, 'Mart'),
                            _buildFiturItem(Icons.agriculture, 'Info Pangan'),
                            _buildFiturItem(Icons.location_on, 'Lokasi', onTap: () {
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

      // Bottom Navigation Bar dengan navigasi ke Halaman Pengiriman dan Profil
      bottomNavigationBar: Container(
        height: 50,  // Menurunkan tinggi untuk navbar lebih ringkas
        decoration: const BoxDecoration(
          color: Color(0xFF224D31),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Menggunakan transparan
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: _currentIndex,
          iconSize: 20, // Ukuran icon lebih kecil
          selectedFontSize: 10, // Ukuran font label lebih kecil
          unselectedFontSize: 10, // Ukuran font label lebih kecil
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              if (_currentIndex == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShippingPage()),
                );
              } else if (_currentIndex == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              }
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping),
              label: 'Pengiriman',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
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
