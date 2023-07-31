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

        // Sort _sailorSearchResult and _clothSellerSearchResult based on isFeaturedSeller
        _sailorSearchResult.sort((seller1, seller2) {
          bool isFeatured1 = seller1.containsKey("isFeaturedSeller") &&
              seller1["isFeaturedSeller"] as bool;
          bool isFeatured2 = seller2.containsKey("isFeaturedSeller") &&
              seller2["isFeaturedSeller"] as bool;
          return isFeatured2 ? 1 : 0;
        });

        _clothSellerSearchResult.sort((seller1, seller2) {
          bool isFeatured1 = seller1.containsKey("isFeaturedSeller") &&
              seller1["isFeaturedSeller"] as bool;
          bool isFeatured2 = seller2.containsKey("isFeaturedSeller") &&
              seller2["isFeaturedSeller"] as bool;
          return isFeatured2 ? 1 : 0;
        });
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
