import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String fullName = "Imam";
    final String title = "Peternak";
    final String email = "carrie_sanders@email.com";
    final String phone = "080977665";
    final String address = "Lamongan, Jawa Timur";
    final String password = "••••••••"; // Password disembunyikan

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: const Color(0xFF224D31),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Photo with circular frame
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile_picture.jpg'), // Update with the correct image path
                backgroundColor: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20),
            // Full Name
            Center(
              child: Text(
                fullName,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Title
            Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                    fontSize: 18, color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 20),
            // Divider and Contact Info
            _buildInfoRow(Icons.email, email),
            const Divider(color: Colors.grey, thickness: 1),
            _buildInfoRow(Icons.phone, phone),
            const Divider(color: Colors.grey, thickness: 1),
            _buildInfoRow(Icons.location_on, address),
            const Divider(color: Colors.grey, thickness: 1),
            _buildInfoRow(Icons.lock, password), // Password section
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF224D31)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              info,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
