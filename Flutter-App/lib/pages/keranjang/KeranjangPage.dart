import 'package:flutter/material.dart';
import 'package:naturefarm/model/keranjang/KeranjangProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class KeranjangPage extends StatelessWidget {
  final String adminWhatsApp = "6282234840257";

  const KeranjangPage({Key? key}) : super(key: key);

  Future<void> _checkoutWithWhatsApp(BuildContext context) async {
    final cart = Provider.of<KeranjangProvider>(context, listen: false);

    if (cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keranjang kosong')),
      );
      return;
    }

    // Buat pesan untuk WhatsApp
    String message = "Halo, saya ingin memesan:\n\n";

    for (var item in cart.items) {
      message += "- ${item.nama} (${item.jenis}) x ${item.quantity}\n";
    }

    message += "\nTotal: Rp ${cart.totalHarga}";

    try {
      final whatsappUrl = Uri.parse(
          "https://wa.me/$adminWhatsApp?text=${Uri.encodeComponent(message)}");

      if (await canLaunchUrl(whatsappUrl)) {
        // Tampilkan dialog konfirmasi
        final bool? confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Konfirmasi Pesanan'),
            content: const Text(
                'Anda akan diarahkan ke WhatsApp untuk menyelesaikan pesanan. Lanjutkan?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Lanjutkan',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF224D31),
                ),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);

          // Kosongkan keranjang setelah checkout
          cart.clear();
        }
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Keranjang',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF224D31),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Kosongkan Keranjang'),
                  content:
                      const Text('Anda yakin ingin mengosongkan keranjang?'),
                  actions: [
                    TextButton(
                      child: const Text('Batal'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text('Ya'),
                      onPressed: () {
                        Provider.of<KeranjangProvider>(context, listen: false)
                            .clear();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<KeranjangProvider>(
        builder: (context, cart, child) {
          // Tampilkan loading indicator saat memuat data
          if (cart.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Tampilkan keranjang kosong
          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Keranjang Kosong',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          // Tampilkan daftar item keranjang
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Gambar
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: item.gambar.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(item.gambar),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: item.gambar.isEmpty
                                  ? const Icon(Icons.image_not_supported,
                                      size: 40)
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            // Info produk
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.nama,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Jenis: ${item.jenis.toUpperCase()}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Rp ${item.harga}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF224D31),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Kontrol jumlah
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    if (item.quantity > 1) {
                                      cart.updateQuantity(
                                        item.id,
                                        item.jenis,
                                        item.quantity - 1,
                                      );
                                    }
                                  },
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    cart.updateQuantity(
                                      item.id,
                                      item.jenis,
                                      item.quantity + 1,
                                    );
                                  },
                                ),
                              ],
                            ),
                            // Hapus item
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                cart.removeItem(item.id, item.jenis);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Total dan checkout
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Pesanan:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rp ${cart.totalHarga}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF224D31),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          icon: const FaIcon(FontAwesomeIcons.whatsapp),
                          label: const Text(
                            'Checkout via WhatsApp',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25D366),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () => _checkoutWithWhatsApp(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
