import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckoutScreenProvider extends ChangeNotifier {
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  final userId = FirebaseAuth.instance.currentUser!.uid;

  String _kategori = 'ATASAN';
  String _jenis = 'Batik';
  String _jasa = 'Jahit termasuk bahan';
  String _size = 'S';
  String _alamat = 'Belum ada alamat';

  String _deskripsi = '';

  String _delivery = '';

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

  void setAlamat(String alamat) {
    _alamat = alamat;
    notifyListeners();
  }

  String get getKategori => _kategori;
  String get getJenis => _jenis;
  String get getJasa => _jasa;
  String get getSize => _size;

  String get getDeskripsi => _deskripsi;

  String get getDelivery => _delivery;

  String get getAlamat => _alamat;

  Map<String, dynamic> get detailJasa => _detailJasa;

  void setDetailJasa(String kategori, String jenis, String jasa, String size) {
    _detailJasa['kategori'] = kategori;
    _detailJasa['jenis'] = jenis;
    _detailJasa['jasa'] = jasa;
    _detailJasa['size'] = size;
    notifyListeners();
  }

  Future<void> sendCheckoutData() async {
    await orders.doc().set({
      'uid': userId,
      'kategori': _kategori,
      'jenis': _jenis,
      'jasa': _jasa,
      'size': _size,
      'alamat': _alamat,
      'deskripsi': _deskripsi,
      'delivery': _delivery,
    });
  }
}
