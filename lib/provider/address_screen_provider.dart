import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddressScreenProvider extends ChangeNotifier {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  List<Map<String, dynamic>> _addressUser = [];
  List<Map<String, dynamic>> get addresUser => _addressUser;

  Future<void> fetchAddressUser() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc()
          .collection('sendLocation')
          .get();
      if (snapshot.docs.isNotEmpty) {
        _addressUser = snapshot.docs.map((doc) => doc.data()).toList();
      } else {
        _addressUser = [];
      }
    } catch (error) {
      print('Error fetching address: $error');
    }
    notifyListeners();
  }
}
