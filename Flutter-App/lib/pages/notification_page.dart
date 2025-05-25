import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  final List<Map<String, String>> _notifications = const [
    {
      'title': 'Pesanan kamu atas Kambing Etawa telah berhasil.',
      'time': 'Baru saja',
    },
    {
      'title': 'Pembayaran kamu sedang diproses.',
      'time': '10 menit lalu',
    },
    {
      'title': 'Pesanan Kambing PO kamu sedang dikirim.',
      'time': '1 jam lalu',
    },
    {
      'title': 'Pesanan sebelumnya telah sampai. Jangan lupa beri ulasan ya!',
      'time': 'Kemarin',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF224D31),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notif = _notifications[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: const Icon(
                Icons.notifications_active_rounded,
                color: Color(0xFF224D31),
                size: 32,
              ),
              title: Text(
                notif['title']!,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                notif['time']!,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
