import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailScreenProvider extends ChangeNotifier {
  Map<String, dynamic>? _detailScreenData;
  Map<String, dynamic>? get detailScreenData => _detailScreenData;

  Future<void> fetchDetailScreenData(int id) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('seller')
          .where("id", isEqualTo: id)
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

  void clearData() {
    _detailScreenData = {};
    notifyListeners();
  }
}
