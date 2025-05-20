import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class FlutterMapPage extends StatefulWidget {
  const FlutterMapPage({super.key});

  @override
  State<FlutterMapPage> createState() => _FlutterMapPageState();
}

class _FlutterMapPageState extends State<FlutterMapPage> {
  final LatLng lokasiPakTekno =
      LatLng(-7.122833, 112.250567); // Koordinat lokasi

  void _bukaRuteDiGoogleMaps(BuildContext context) async {
    try {
      final Uri url = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&destination=${lokasiPakTekno.latitude},${lokasiPakTekno.longitude}');

      if (await canLaunchUrl(url)) {
        final bool launched = await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );

        if (!launched) {
          throw 'Could not launch Google Maps';
        }
      } else {
        // Tampilkan dialog jika tidak bisa membuka Maps
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'Tidak dapat membuka Google Maps. Pastikan aplikasi Maps terinstall di emulator.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Tampilkan pesan error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2EEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF224D31),
        title: Text('Lokasi', style: TextStyle(color: Colors.white)),
        leading: BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "Jual Beli Kambing Pak Tekno",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(width: 8),
              Expanded(
                  child: Text("Menongo, Kec. Sukodadi, Kabupaten Lamongan")),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: 8),
              Text("+62 821 9045 4089"),
            ],
          ),
          SizedBox(height: 16),

          // PETA
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 300,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: lokasiPakTekno,
                  initialZoom: 16,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: lokasiPakTekno,
                        width: 80,
                        height: 80,
                        child: Icon(Icons.location_on,
                            size: 40, color: Colors.red),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // TOMBOL RUTE
          ElevatedButton.icon(
            onPressed: () => _bukaRuteDiGoogleMaps(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF224D31),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            icon: Icon(Icons.directions),
            label: Text("Lihat Rute ke Lokasi"),
          ),
        ],
      ),
    );
  }
}
