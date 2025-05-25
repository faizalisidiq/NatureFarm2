import 'package:flutter/material.dart';
import 'package:naturefarm/model/artikel/artikel.dart';

class ArticleDetailPage extends StatefulWidget {
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.article.judul_artikel,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white, // Menambahkan warna putih untuk judul
            fontWeight: FontWeight.bold, // Opsional: menambahkan bold
          ),
        ),
        backgroundColor: const Color(0xFF224D31),
        iconTheme: const IconThemeData(
          color: Colors.white, // Memastikan warna icon back juga putih
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Artikel dengan error handling
            if (widget.article.gambar != null &&
                widget.article.gambar!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  // 'http://10.0.2.2:8000/storage/${widget.article.gambar}',
                  'http://127.0.0.1:8000/storage/${widget.article.gambar}', // API untuk web
                  // 'http://18.138.155.224/storage/${widget.article.gambar}', // API untuk AWS
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading image: $error');
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),

            // Isi Artikel dengan null check
            Text(
              widget.article.isi_artikel ?? 'Tidak ada konten',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up resources
    super.dispose();
  }
}
