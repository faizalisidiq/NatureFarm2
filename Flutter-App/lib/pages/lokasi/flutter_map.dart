import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class FlutterMapPage extends StatefulWidget {
  const FlutterMapPage({super.key});

  @override
  State<FlutterMapPage> createState() => _FlutterMapPageState();
}

class _FlutterMapPageState extends State<FlutterMapPage> {
  final LatLng lokasiPakTekno =
      LatLng(-7.122833, 112.250567); // Koordinat lokasi

  // Modifikasi fungsi _bukaRuteDiGoogleMaps
  void _bukaRuteDiGoogleMaps(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Cara Melihat Lokasi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Buka di Google Maps'),
                onTap: () async {
                  Navigator.pop(context);
                  try {
                    final Uri googleMapsUri = Uri.parse(
                        'https://www.google.com/maps/dir/?api=1&destination=${lokasiPakTekno.latitude},${lokasiPakTekno.longitude}');

                    if (await canLaunchUrl(googleMapsUri)) {
                      await launchUrl(
                        googleMapsUri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      throw 'Tidak dapat membuka Google Maps';
                    }
                  } catch (e) {
                    _showErrorSnackbar(context, e.toString());
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.public),
                title: Text('Buka di Browser'),
                onTap: () async {
                  Navigator.pop(context);
                  try {
                    final Uri browserUri = Uri.parse(
                        'https://www.google.com/maps?q=${lokasiPakTekno.latitude},${lokasiPakTekno.longitude}');

                    if (await canLaunchUrl(browserUri)) {
                      await launchUrl(
                        browserUri,
                        mode: LaunchMode.inAppWebView,
                      );
                    } else {
                      throw 'Tidak dapat membuka browser';
                    }
                  } catch (e) {
                    _showErrorSnackbar(context, e.toString());
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.content_copy),
                title: Text('Salin Koordinat'),
                onTap: () {
                  Navigator.pop(context);
                  Clipboard.setData(ClipboardData(
                      text:
                          '${lokasiPakTekno.latitude}, ${lokasiPakTekno.longitude}'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Koordinat disalin ke clipboard')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $message'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
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
            icon: Icon(Icons.directions, color: Colors.white),
            label: Text(
              "Lihat Rute ke Lokasi",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
