class Article {
  final String judul_artikel;
  final String isi_artikel;
  final String? gambar;
  final DateTime createdAt;
  final DateTime updatedAt;

  Article({
    required this.judul_artikel,
    required this.isi_artikel,
    this.gambar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      judul_artikel: json['judul_artikel'],
      isi_artikel: json['isi_artikel'],
      gambar: json['gambar'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
