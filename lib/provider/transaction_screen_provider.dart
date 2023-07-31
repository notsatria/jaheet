import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionScreenProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
<<<<<<< HEAD
  final userId = FirebaseAuth.instance.currentUser!.uid;
=======
  final userid = FirebaseAuth.instance.currentUser!.uid;
>>>>>>> 15a58a2e86e199a29adb90fecd4789cf6c1472bf
  final String id = 'RNUprDRh66SPSJGzDMyf3xlcIAq2';

  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  Map<String, dynamic>? _detailScreenData;
  Map<String, dynamic>? get detailScreenData => _detailScreenData;

  Future<void> fetchOrders() async {
    try {
      final snapshot = await firestore
          .collection("orders")
<<<<<<< HEAD
          .where('uid', isEqualTo: userId)
=======
          .where('uid', isEqualTo: userid)
>>>>>>> 15a58a2e86e199a29adb90fecd4789cf6c1472bf
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
}
