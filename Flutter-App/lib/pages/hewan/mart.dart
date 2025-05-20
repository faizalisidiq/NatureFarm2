import 'package:flutter/material.dart';
import 'package:naturefarm/model/hewan/hewan.dart';
import 'package:naturefarm/model/hewan/repoHewan.dart';

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
          color: Colors.white, // Mengubah warna tanda panah menjadi putih
        ),
        title: const Text("List Hewan",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white, // Menambahkan warna putih untuk judul
              fontWeight: FontWeight.bold, // Opsional: menambahkan bold
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
      body: publishedHewan.isEmpty // Gunakan publishedHewan alih-alih listHewan
          ? const Center(
              child: CircularProgressIndicator()) // Menampilkan loading
          : ListView.separated(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      publishedHewan[index]
                          .nama_hewan, // Gunakan publishedHewan
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Jenis Kelamin: ${publishedHewan[index].jenis_kelamin}'),
                        Text('Deskripsi: ${publishedHewan[index].deskripsi}'),
                        Text('Stok: ${publishedHewan[index].stok}'),
                        // Menampilkan gambar
                        if (publishedHewan[index].gambar.isNotEmpty)
                          Image.network(
                            publishedHewan[index].gambar, // URL gambar lengkap
                            width: 100,
                            height: 100,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons
                                  .error); // Menampilkan ikon jika gambar gagal dimuat
                            },
                          ),
                      ],
                    ),
                    isThreeLine: true,
                    leading: CircleAvatar(
                        child: Text(publishedHewan[index].nama_hewan[0])),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 4);
              },
              itemCount: publishedHewan.length, // Gunakan publishedHewan.length
            ),
    );
  }
}
