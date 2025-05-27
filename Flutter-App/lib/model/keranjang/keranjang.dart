class KeranjangItem {
  final int id;
  final String nama;
  final String gambar;
  final String jenis; // 'hewan' atau 'pakan'
  final int harga;
  int quantity;

  KeranjangItem({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.jenis,
    required this.harga,
    this.quantity = 1,
  });

  // Tambahkan metode toJson untuk serialisasi
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'gambar': gambar,
      'jenis': jenis,
      'harga': harga,
      'quantity': quantity,
    };
  }

  // Tambahkan factory constructor untuk deserialisasi
  factory KeranjangItem.fromJson(Map<String, dynamic> json) {
    return KeranjangItem(
      id: json['id'],
      nama: json['nama'],
      gambar: json['gambar'],
      jenis: json['jenis'],
      harga: json['harga'],
      quantity: json['quantity'],
    );
  }
}
