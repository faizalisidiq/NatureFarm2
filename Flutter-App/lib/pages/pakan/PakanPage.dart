import 'package:flutter/material.dart';
import 'package:naturefarm/model/pakan/RepoPakan.dart';
import 'package:naturefarm/model/pakan/pakan.dart';
import 'package:naturefarm/pages/pakan/DetailPakan.dart';

class PakanListScreen extends StatefulWidget {
  @override
  _PakanListScreenState createState() => _PakanListScreenState();
}

class _PakanListScreenState extends State<PakanListScreen> {
  late Future<List<Pakan>> futurePakanList;
  final RepoPakan apiService = RepoPakan();
  List<Pakan> publishedPakan = []; // Add this line

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Mengubah warna tanda panah menjadi putih
        ),
        title: const Text("List Pakan",
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
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<Pakan>>(
          future: futurePakanList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${snapshot.error}'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          futurePakanList = apiService.getPakanList();
                        });
                      },
                      child: Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Tidak ada data pakan'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Pakan pakan = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: pakan.gambar != null && pakan.gambar!.isNotEmpty
                            ? Image.network(
                                'http://10.0.2.2:8000/storage/${pakan.gambar}', // Changed URL path
                                // 'http://127.0.0.1:8000/storage/${pakan.gambar}', // API untuk web
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  print('Error loading image: $error');
                                  print('Image path: ${pakan.gambar}');
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.broken_image),
                                  );
                                },
                              )
                            : Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[300],
                                child: const Icon(Icons.fastfood),
                              ),
                      ),
                      title: Text(pakan.namaPakan),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Stok: ${pakan.stok}'),
                          const SizedBox(height: 4), // Add spacing
                          Text(
                            pakan.deskripsi,
                            maxLines: 2, // Limit to 2 lines
                            overflow: TextOverflow
                                .ellipsis, // Add ... if text is too long
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4), // Add spacing
                          // Chip(
                          //   label: Text(
                          //     pakan.statusText,
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          //   backgroundColor: pakan.statusColor,
                          // ),
                        ],
                      ),
                      isThreeLine: true, // Enable three line layout
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => PakanDetailScreen(pakan: pakan),
                      //     ),
                      //   );
                      // },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
