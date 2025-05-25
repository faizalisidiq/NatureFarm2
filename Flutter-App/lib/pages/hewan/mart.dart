import 'package:flutter/material.dart';
import 'package:naturefarm/model/hewan/hewan.dart';
import 'package:naturefarm/model/hewan/repoHewan.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HewanPage extends StatefulWidget {
  const HewanPage({super.key});

  @override
  State<HewanPage> createState() => _HewanPageState();
}

class _HewanPageState extends State<HewanPage> {
  List<Hewan> listHewan = [];
  List<Hewan> publishedHewan = []; // Tambahkan list untuk hewan yang published
  RepoHewan repoHewan = RepoHewan();
  late Future<List<Hewan>> futureHewanList;

  // Nomor WhatsApp admin (ganti dengan nomor yang sebenarnya)
  final String adminWhatsApp = "6282234840257"; // Format: kode negara tanpa +

  // Fungsi untuk mengambil data dari API
  getData() async {
    try {
      final response = await repoHewan.getData();
      // print(response);
      setState(() {
        listHewan =
            response; // Pastikan listHewan diperbarui dengan data yang benar
        // Filter hanya hewan dengan status published
        publishedHewan = listHewan
            .where((hewan) => hewan.status.toLowerCase() == 'published')
            .toList();
      });
    } catch (e) {
      print('Error: $e');
      // Tampilkan error ke user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load data'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _refreshData() async {
    try {
      final response = await repoHewan.getData();
      setState(() {
        listHewan = response;
        publishedHewan = listHewan
            .where((hewan) => hewan.status.toLowerCase() == 'published')
            .toList();
      });
      // Tampilkan pesan sukses
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data berhasil diperbarui'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memperbarui data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Di class _HewanPageState, tambahkan fungsi untuk dialog pemesanan
  void _showOrderDialog(Hewan hewan) {
    int quantity = 1; // Default jumlah pesanan

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Pesan ${hewan.nama_hewan}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Pilih jumlah:'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '$quantity',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            if (quantity < hewan.stok) quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Stok tersedia: ${hewan.stok}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Batal'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 16),
                  label: const Text('Pesan Sekarang'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _openWhatsApp(hewan, quantity);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Update fungsi _openWhatsApp untuk menerima parameter quantity
  void _openWhatsApp(Hewan hewan, [int quantity = 1]) async {
    try {
      // Format pesan untuk WhatsApp dengan jumlah pesanan
      final message =
          "Halo, saya tertarik dengan ${hewan.nama_hewan} yang dijual di NaturFarm. Saya ingin memesan sebanyak $quantity ekor. Apakah masih tersedia?";

      // URL untuk membuka WhatsApp
      final whatsappUrl = Uri.parse(
          "https://wa.me/$adminWhatsApp?text=${Uri.encodeComponent(message)}");

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error membuka WhatsApp: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
    futureHewanList = repoHewan.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Katalog Hewan",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF224D31),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshData,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: publishedHewan.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: publishedHewan.length,
                itemBuilder: (context, index) {
                  final hewan = publishedHewan[index];
                  return _buildHewanCard(hewan);
                },
              ),
            ),
    );
  }

  Widget _buildHewanCard(Hewan hewan) {
    return SizedBox(
      height: 260, // Atur tinggi tetap sesuai kebutuhan
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar hewan
            SizedBox(
              height: 90,
              width: double.infinity,
              child: hewan.gambar.isNotEmpty
                  ? Image.network(
                      hewan.gambar,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image, size: 50),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.photo, size: 50),
                      ),
                    ),
            ),
            // Informasi dan tombol
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hewan.nama_hewan,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hewan.deskripsi,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Stok: ${hewan.stok}",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 16),
                  label: const Text('Pesan', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: () => _showOrderDialog(hewan),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
