class Hewan {
  final String nama_hewan;
  final String jenis_kelamin;
  final String deskripsi;
  final int stok;
  final String status;
  final String gambar; // Nama file gambar
  final String createdAt;
  final String updatedAt;

  Hewan({
    required this.nama_hewan,
    required this.jenis_kelamin,
    required this.deskripsi,
    required this.stok,
    required this.status,
    required this.gambar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Hewan.fromJson(Map<String, dynamic> json) {
    // Membuat URL gambar lengkap berdasarkan nama file
    String imageUrl =
          // 'http://10.0.2.2:8000/storage/${json['gambar']}'; // API untuk emulator
        'http://127.0.0.1:8000/storage/${json['gambar']}'; // API untuk web
        // 'http://18.138.155.224/storage/${json['gambar']}'; // API untuk server AWS

    return Hewan(
      nama_hewan: json['nama_hewan'],
      jenis_kelamin: json['jenis_kelamin'],
      deskripsi: json['deskripsi'],
      stok: json['stok'],
      status: json['status'],
      gambar: imageUrl, // Menggunakan URL lengkap
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  @override
  String toString() {
    return 'Nama Hewan: $nama_hewan, Jenis Kelamin: $jenis_kelamin, Stok: $stok, Status: $status, Gambar: $gambar';
  }
}
