import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionScreenProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String id = 'RNUprDRh66SPSJGzDMyf3xlcIAq2';

  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  String _sellerName = '';

  Future<void> fetchOrders() async {
    try {
      final snapshot = await firestore
          .collection("orders")
          .where('uid', isEqualTo: id)
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
}
