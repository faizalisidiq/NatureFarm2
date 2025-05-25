import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String fullName = "Leanor";
    final String title = "Pembeli";
    final String email = "carrie_sanders@email.com";
    final String phone = "080977665";
    final String address = "Lamongan, Jawa Timur";
    final String password = "••••••••";

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F2), // Latar belakang lembut
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF224D31),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile_picture.jpg'),
                backgroundColor: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              fullName,
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            // Card Info
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.email_rounded, email),
                    const Divider(),
                    _buildInfoRow(Icons.phone_rounded, phone),
                    const Divider(),
                    _buildInfoRow(Icons.location_on_rounded, address),
                    const Divider(),
                    _buildInfoRow(Icons.lock_rounded, password),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String info) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF224D31)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            info,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
