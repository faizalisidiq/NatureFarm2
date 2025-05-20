class Pakan {
  final int id;
  final String namaPakan;
  final String deskripsi;
  final int stok;
  final String status;
  final String? gambar;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pakan({
    required this.id,
    required this.namaPakan,
    required this.deskripsi,
    required this.stok,
    required this.status,
    this.gambar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pakan.fromJson(Map<String, dynamic> json) {
    return Pakan(
      id: json['id'],
      namaPakan: json['nama_pakan'],
      deskripsi: json['deskripsi'],
      stok: json['stok'],
      status: json['status'],
      gambar: json['gambar'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  bool get isPublished => status == 'published';
}