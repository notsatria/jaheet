import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionScreenProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userid = FirebaseAuth.instance.currentUser!.uid;

  String _orderId = '';
  String get orderId => _orderId;

  String _sellerId = '';
  String get sellerId => _sellerId;

  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  Map<String, dynamic>? _detailScreenData;
  Map<String, dynamic>? get detailScreenData => _detailScreenData;

  void setSellerId(String id) {
    _sellerId = id;
    notifyListeners();
  }

  void setOrderId(String id) {
    _orderId = id;
  }

  Future<void> fetchOrders() async {
    try {
      final snapshot = await firestore
          .collection("orders")
          .where('uid', isEqualTo: userid)
          .get();
      if (snapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> orderData =
            snapshot.docs.map((doc) => doc.data()).toList();
        _orders = orderData;
      } else {}
    } catch (error) {
      debugPrint('Error fetching data: $error');
    }
    notifyListeners();
  }

  Future<void> fetchDetailScreenData(String orderid) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where("orderid", isEqualTo: orderid)
          .get();
      if (snapshot.docs.isNotEmpty) {
        _detailScreenData = snapshot.docs.first.data();
        print(_detailScreenData);
      } else {
        _detailScreenData = null;
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
    notifyListeners();
  }

  Future<void> sendTotalTagihan(int totalTagihan, String orderid) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .where("orderid", isEqualTo: orderid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.update({'total_harga': totalTagihan});
      });
    });
  }
}
