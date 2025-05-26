import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naturefarm/model/pakan/RepoPakan.dart';
import 'package:naturefarm/model/pakan/pakan.dart';
import 'package:url_launcher/url_launcher.dart';

class PakanListScreen extends StatefulWidget {
  @override
  _PakanListScreenState createState() => _PakanListScreenState();
}

class _PakanListScreenState extends State<PakanListScreen> {
  late Future<List<Pakan>> futurePakanList;
  final RepoPakan apiService = RepoPakan();
  List<Pakan> publishedPakan = [];

  // Nomor WhatsApp admin
  final String adminWhatsApp = "6282234840257"; // Format: kode negara tanpa +

  @override
  void initState() {
    super.initState();
    futurePakanList = _getPublishedPakan();
  }

  Future<List<Pakan>> _getPublishedPakan() async {
    try {
      final allPakan = await apiService.getPakanList();
      return allPakan
          .where((pakan) => pakan.status.toLowerCase() == 'published')
          .toList();
    } catch (e) {
      throw Exception('Failed to load published pakan: $e');
    }
  }

  Future<void> _refreshData() async {
    try {
      setState(() {
        futurePakanList = _getPublishedPakan();
      });

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

  void _showOrderDialog(Pakan pakan) {
    int quantity = 1; // Default jumlah pesanan

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Pesan ${pakan.namaPakan}'),
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
                            if (quantity < pakan.stok) quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Stok tersedia: ${pakan.stok}',
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
                    _openWhatsApp(pakan, quantity);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _openWhatsApp(Pakan pakan, [int quantity = 1]) async {
    try {
      // Format pesan untuk WhatsApp dengan jumlah pesanan
      final message =
          "Halo, saya tertarik dengan pakan ${pakan.namaPakan} yang dijual di NaturFarm. Saya ingin memesan sebanyak $quantity. Apakah masih tersedia?";

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("Katalog Pakan",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: const Color(0xFF224D31),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshData,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<Pakan>>(
          future: futurePakanList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${snapshot.error}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          futurePakanList = _getPublishedPakan();
                        });
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada data pakan'));
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Pakan pakan = snapshot.data![index];
                  return _buildPakanCard(pakan);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPakanCard(Pakan pakan) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar
            SizedBox(
              height: 120,
              width: double.infinity,
              child: pakan.gambar != null && pakan.gambar!.isNotEmpty
                  ? Image.network(
                      // 'http://10.0.2.2:8000/storage/${pakan.gambar}',
                      // 'http://127.0.0.1:8000/storage/${pakan.gambar}',
                      'http://18.138.155.224/storage/${pakan.gambar}',

                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading image: $error');
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.fastfood),
                      ),
                    ),
            ),
            // Info Produk
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pakan.namaPakan,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pakan.deskripsi,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stok: ${pakan.stok}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Tombol Pesan
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  onPressed: () => _showOrderDialog(pakan),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
