import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckoutScreenProvider extends ChangeNotifier {
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  final userId = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference sellers = FirebaseFirestore.instance.collection('seller');

  String _kategori = 'ATASAN';
  String _jenis = 'Batik';
  String _jasa = 'Jahit termasuk bahan';
  String _size = 'S';
  String _hargaMinimal = '10000';
  String _hargaMaksimal = '20000';
  String _orderStatus = 'Menunggu Konfirmasi';
  final String _biayaJasa = '0';

  Map<String, dynamic> _detailAlamatPemesan = {};
  Map<String, dynamic> _detailAlamatPenjual = {};

  String _deskripsi = '';

  String _delivery = '';

  String _date = '';

  int _sellerId = 0;

  final String _status = 'Menunggu konfirmasi';

  final Map<String, dynamic> _detailJasa = {
    'kategori': '',
    'jenis': '',
    'jasa': '',
    'size': '',
  };

  void setKategori(String kategori) {
    _kategori = kategori;
    notifyListeners();
  }

  void setJenis(String jenis) {
    _jenis = jenis;
    notifyListeners();
  }

  void setJasa(String jasa) {
    _jasa = jasa;
    notifyListeners();
  }

  void setSize(String size) {
    _size = size;
    notifyListeners();
  }

  void setDeskripsi(String deskripsi) {
    _deskripsi = deskripsi;
    notifyListeners();
  }

  void setDelivery(String option) {
    _delivery = option;
    notifyListeners();
  }

  void setOrderdate(String date) {
    _date = date;
    notifyListeners();
  }

  void setSellerId(int sellerId) {
    _sellerId = sellerId;
    notifyListeners();
  }

  void setOrderStatus(String status) {
    _orderStatus = status;
    notifyListeners();
  }

  void setDetailAlamatPenerima(Map<String, dynamic> alamatPenerima) {
    _detailAlamatPemesan = alamatPenerima;
    notifyListeners();
  }

  void setDetailAlamatPenjual(Map<String, dynamic> alamatPenjual) {
    _detailAlamatPenjual = alamatPenjual;
    notifyListeners();
  }

  void setHarga(String hargaMinimal, String hargaMaksimal) {
    _hargaMinimal = hargaMinimal;
    _hargaMaksimal = hargaMaksimal;
    notifyListeners();
  }

  String get getKategori => _kategori;
  String get getJenis => _jenis;
  String get getJasa => _jasa;
  String get getSize => _size;
  String get getDeskripsi => _deskripsi;
  String get getDelivery => _delivery;
  String get getOrderStatus => _orderStatus;

  String get getHargaMinimal => _hargaMinimal;
  String get getHargaMaksimal => _hargaMaksimal;

  Map<String, dynamic> get detailAlamatPemesan => _detailAlamatPemesan;
  Map<String, dynamic> get detailAlamatPenjual => _detailAlamatPenjual;

  String get getOrderDate => _date;

  int get getSellerId => _sellerId;

  Map<String, dynamic> get detailJasa => _detailJasa;

  void setDetailJasa(String kategori, String jenis, String jasa, String size) {
    _detailJasa['kategori'] = kategori;
    _detailJasa['jenis'] = jenis;
    _detailJasa['jasa'] = jasa;
    _detailJasa['size'] = size;
    notifyListeners();
  }

  String generateOrderId() {
    return '$_sellerId-$_date';
  }

  Future<void> getPrice(int id) async {
    try {
      final QuerySnapshot snapshot = await sellers
          .doc(id.toString())
          .collection("jasa")
          .where("title",
              isEqualTo:
                  _kategori) // Assuming _jasa is defined elsewhere in your code.
          .get();
      if (snapshot.docs.isNotEmpty) {
        Map<String, dynamic> data =
            snapshot.docs.first.data() as Map<String, dynamic>;
        print(data);
        _hargaMinimal = data['minPrice']; // Convert int to String
        _hargaMaksimal = data['maxPrice']; // Convert int to String
      } else {
        _hargaMinimal = '0';
        _hargaMaksimal = '10000';
      }
    } catch (error) {
      print('Error getting price: $error');
      return;
    }
  }

  Future<void> sendCheckoutData() async {
    await orders.doc().set({
      'uid': userId,
      'kategori': _kategori,
      'jenis': _jenis,
      'jasa': _jasa,
      'size': _size,
      'harga_minimal': _hargaMinimal,
      'harga_maksimal': _hargaMaksimal,
      'alamat_pemesan': _detailAlamatPemesan,
      'alamat_penjual': _detailAlamatPenjual,
      'deskripsi': _deskripsi,
      'delivery': _delivery,
      'order-date': _date,
      'sellerid': _sellerId,
      'order_status': _orderStatus,
      'orderid': generateOrderId(),
      'status': _status,
      'biaya_jasa': _biayaJasa,
    });
  }
}
