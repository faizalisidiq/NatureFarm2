import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  List<Map<String, String>> _deliveryStatusList = [
    {
      'time': '22 Apr 09:40',
      'status': 'Pesanan tiba di kota tujuan dan diterima oleh penerima.',
      'icon': 'check_circle', // Menggunakan ikon check_circle
    },
    {
      'time': '22 Apr 07:08',
      'status': 'Kambing/sapi dalam proses pengantaran menuju kota tujuan.',
      'icon': 'local_shipping', // Menggunakan ikon local_shipping
    },
    {
      'time': '22 Apr 07:07',
      'status': 'Mobil pickup sudah ditugaskan. Kambing/sapi sedang dalam perjalanan.',
      'icon': 'directions_car', // Menggunakan ikon directions_car
    },
    {
      'time': '21 Apr 23:58',
      'status': 'Proses pickup selesai, kambing/sapi dipindahkan ke kendaraan pengantar.',
      'icon': 'done_all', // Menggunakan ikon done_all
    },
    {
      'time': '21 Apr 22:41',
      'status': 'Pesanan sudah siap diambil menggunakan mobil pickup.',
      'icon': 'check_box', // Menggunakan ikon check_box
    },
    {
      'time': '21 Apr 21:27',
      'status': 'Pesanan telah diproses dan siap untuk dijemput oleh kendaraan pengantar.',
      'icon': 'assignment_turned_in', // Menggunakan ikon assignment_turned_in
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF224D31),
        title: const Text('Status Pengiriman'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Ikon Pengiriman besar di bagian atas
            Icon(
              Icons.local_shipping,
              color: const Color(0xFF224D31),
              size: 120,
            ),
            const SizedBox(height: 20),
            // Menampilkan setiap status pengiriman dengan Timeline
            Expanded(
              child: ListView.builder(
                itemCount: _deliveryStatusList.length,
                itemBuilder: (context, index) {
                  var status = _deliveryStatusList[index];
                  return _buildStatusItem(status['time']!, status['status']!, status['icon']!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun tampilan status pengiriman dengan Card dan ikon
  Widget _buildStatusItem(String time, String status, String iconName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              // Ikon pengiriman untuk setiap status menggunakan Icons
              Icon(
                _getIcon(iconName), // Menentukan ikon berdasarkan nama
                color: const Color(0xFF224D31),
                size: 40,
              ),
              const SizedBox(width: 12),
              // Waktu dan status pengiriman
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Waktu
                    Text(
                      time,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Deskripsi status pengiriman
                    Text(
                      status,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Color(0xFF224D31),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk mengambil ikon berdasarkan nama ikon
  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'check_circle':
        return Icons.check_circle;
      case 'local_shipping':
        return Icons.local_shipping;
      case 'directions_car':
        return Icons.directions_car;
      case 'done_all':
        return Icons.done_all;
      case 'check_box':
        return Icons.check_box;
      case 'assignment_turned_in':
        return Icons.assignment_turned_in;
      default:
        return Icons.error; // Ikon default jika tidak ada yang cocok
    }
  }
}
