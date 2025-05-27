import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naturefarm/model/keranjang/keranjang.dart';
import 'package:naturefarm/model/pakan/RepoPakan.dart';
import 'package:naturefarm/model/pakan/pakan.dart';
import 'package:naturefarm/pages/keranjang/KeranjangPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart'; // Tambahkan import
import 'package:naturefarm/model/keranjang/KeranjangProvider.dart'; // Tambahkan impor

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
                // Tambahkan tombol untuk menambahkan ke keranjang
                ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_cart, size: 16),
                  label: const Text('Tambah ke Keranjang'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF224D31),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _addToCart(pakan, quantity);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Fungsi baru untuk menambahkan ke keranjang
  void _addToCart(Pakan pakan, int quantity) {
    final keranjangProvider =
        Provider.of<KeranjangProvider>(context, listen: false);

    // Buat url gambar lengkap
    String imageUrl = '';
    if (pakan.gambar != null && pakan.gambar!.isNotEmpty) {
      // imageUrl = 'http://18.138.155.224/storage/${pakan.gambar}';
      //imageUrl = 'http://127.0.0.1/storage/${pakan.gambar}';
      imageUrl = 'http://10.0.2.2/storage/${pakan.gambar}';

    }

    // Tambahkan ke keranjang
    keranjangProvider.addItem(KeranjangItem(
      id: pakan.id,
      nama: pakan.namaPakan,
      gambar: imageUrl,
      jenis: 'pakan', // Identifikasi sebagai pakan
      harga: pakan.harga,
      quantity: quantity,
    ));

    // Tampilkan notifikasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${pakan.namaPakan} ditambahkan ke keranjang'),
        action: SnackBarAction(
          label: 'Lihat Keranjang',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KeranjangPage(),
              ),
            );
          },
        ),
        duration: const Duration(seconds: 2),
      ),
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
          // Tambahkan badge keranjang
          Consumer<KeranjangProvider>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KeranjangPage(),
                        ),
                      );
                    },
                  ),
                  if (cart.totalItems > 0)
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.totalItems}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
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
                  childAspectRatio: 0.65, // Sesuaikan nilai ini
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
                      // 'http://18.138.155.224/storage/${pakan.gambar}',
                      //'http://127.0.0.1:8000/storage/${pakan.gambar}',
                      'http://10.0.2.2:8000/storage/${pakan.gambar}',

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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                    const SizedBox(height: 5),
                    Text(
                      'Stok: ${pakan.stok}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Tampilkan harga jika ada
                    if (pakan.harga > 0)
                      Text(
                        'Rp ${pakan.harga}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF224D31),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Tombol Pesan dan Tambah ke Keranjang
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              width: double.infinity,
              child: Row(
                children: [
                  // Tombol tambah ke keranjang
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF224D31),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        minimumSize: const Size(0, 30),
                      ),
                      onPressed: () => _addToCart(pakan, 1),
                      child: const Icon(Icons.add_shopping_cart, size: 16),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Tombol pesan via WhatsApp
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 14),
                      label:
                          const Text('Pesan', style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        minimumSize: const Size(0, 30),
                      ),
                      onPressed: () => _showOrderDialog(pakan),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
