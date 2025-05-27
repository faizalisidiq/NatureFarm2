import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:naturefarm/model/keranjang/keranjang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeranjangProvider extends ChangeNotifier {
  final List<KeranjangItem> _items = [];
  final String _prefKey = 'naturFarm_keranjang';
  bool _isLoading = true;

  KeranjangProvider() {
    _loadFromPrefs();
  }

  bool get isLoading => _isLoading;

  List<KeranjangItem> get items => [..._items];

  int get itemCount => _items.length;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  int get totalHarga =>
      _items.fold(0, (sum, item) => sum + (item.harga * item.quantity));

  // Metode untuk memuat data dari SharedPreferences
  Future<void> _loadFromPrefs() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? keranjangData = prefs.getString(_prefKey);

      if (keranjangData != null && keranjangData.isNotEmpty) {
        final List<dynamic> decodedData = json.decode(keranjangData);

        _items.clear();
        for (var item in decodedData) {
          _items.add(KeranjangItem(
            id: item['id'],
            nama: item['nama'],
            gambar: item['gambar'],
            jenis: item['jenis'],
            harga: item['harga'],
            quantity: item['quantity'],
          ));
        }
      }
    } catch (e) {
      print('Error loading keranjang data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Metode untuk menyimpan data ke SharedPreferences
  Future<void> _saveToPrefs() async {
    try {
      final List<Map<String, dynamic>> dataToSave = _items
          .map((item) => {
                'id': item.id,
                'nama': item.nama,
                'gambar': item.gambar,
                'jenis': item.jenis,
                'harga': item.harga,
                'quantity': item.quantity,
              })
          .toList();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, json.encode(dataToSave));
    } catch (e) {
      print('Error saving keranjang data: $e');
    }
  }

  // Cek apakah item sudah ada di keranjang
  bool isInCart(int id, String jenis) {
    return _items.any((item) => item.id == id && item.jenis == jenis);
  }

  // Tambah item ke keranjang
  void addItem(KeranjangItem item) {
    final existingIndex =
        _items.indexWhere((i) => i.id == item.id && i.jenis == item.jenis);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    _saveToPrefs();
    notifyListeners();
  }

  // Update jumlah item
  void updateQuantity(int id, String jenis, int quantity) {
    final index =
        _items.indexWhere((item) => item.id == id && item.jenis == item.jenis);

    if (index >= 0 && quantity > 0) {
      _items[index].quantity = quantity;
      _saveToPrefs();
      notifyListeners();
    }
  }

  // Hapus item dari keranjang
  void removeItem(int id, String jenis) {
    _items.removeWhere((item) => item.id == id && item.jenis == item.jenis);
    _saveToPrefs();
    notifyListeners();
  }

  // Kosongkan keranjang
  void clear() {
    _items.clear();
    _saveToPrefs();
    notifyListeners();
  }

  // Untuk debugging - menampilkan item di konsol
  void printItems() {
    print('Keranjang items:');
    for (var item in _items) {
      print('${item.nama} (${item.jenis}) - ${item.quantity} x ${item.harga}');
    }
  }
}
