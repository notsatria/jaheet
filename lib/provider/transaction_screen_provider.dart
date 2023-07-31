import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionScreenProvider extends ChangeNotifier {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference seller = FirebaseFirestore.instance.collection('seller');
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  FirebaseAuth auth = FirebaseAuth.instance;
  final userid = FirebaseAuth.instance.currentUser!.uid;

  final String id = 'RNUprDRh66SPSJGzDMyf3xlcIAq2';

  List<Map<String, dynamic>> _orders = [];

  // List<Map<String, dynamic>> get orders => _orders;

  Map<String, dynamic>? _detailScreenData;
  Map<String, dynamic>? get detailScreenData => _detailScreenData;

  // Future<void> fetchOrders() async {
  //   try {
  //     final snapshot = await firestore
  //         .collection("orders")
  //         .where('uid', isEqualTo: userid)
  //         .get();
  //     if (snapshot.docs.isNotEmpty) {
  //       List<Map<String, dynamic>> orderData =
  //           snapshot.docs.map((doc) => doc.data()).toList();
  //       _orders = orderData;
  //     } else {}
  //   } catch (error) {
  //     debugPrint('Error fetching data: $error');
  //   }
  //   notifyListeners();
  // }

  Future<List<Map<String, dynamic>>> getOrdersData() async {
    final uid = auth.currentUser!.uid;
    final userid = await users.doc(uid).get().then((value) => value.get('uid'));

    if (userid != null) {
      final orderSnapshot = await orders.where('uid', isEqualTo: userid).get();
      if (orderSnapshot.docs.isNotEmpty) {
        // Return a list of order data maps
        return orderSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      }
    }

    // If seller data is not found or no order data is found for the seller, return an empty List.
    return [];
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
