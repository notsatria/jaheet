import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreenProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _sailorSearchResult = [];
  List<Map<String, dynamic>> _clothSellerSearchResult = [];

  List<Map<String, dynamic>> get sailorSearchResult => _sailorSearchResult;
  List<Map<String, dynamic>> get clothSellerSearchResult =>
      _clothSellerSearchResult;

  Future<void> fetchData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("seller").get();
      if (snapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> searchResult =
            snapshot.docs.map((doc) => doc.data()).toList();

        // Clear previous data before adding new data
        _sailorSearchResult.clear();
        _clothSellerSearchResult.clear();

        // Filter data and add to corresponding lists
        for (var data in searchResult) {
          if (data["isSailor"] == true) {
            _sailorSearchResult.add(data);
          }
          if (data["isClothSeller"] == true) {
            _clothSellerSearchResult.add(data);
          }
        }
      } else {
        // If there is no data, clear the result lists
        _sailorSearchResult.clear();
        _clothSellerSearchResult.clear();
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
    notifyListeners();
  }
}
