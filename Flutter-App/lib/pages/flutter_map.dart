import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class FlutterMapPage extends StatelessWidget {
  final LatLng lokasiPakTekno = LatLng(-7.122833, 112.250567); // Koordinat lokasi

  void _bukaRuteDiGoogleMaps() async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=${lokasiPakTekno.latitude},${lokasiPakTekno.longitude}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak bisa membuka Google Maps';
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
              Expanded(child: Text("Menongo, Kec. Sukodadi, Kabupaten Lamongan")),
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
            onPressed: _bukaRuteDiGoogleMaps,
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
