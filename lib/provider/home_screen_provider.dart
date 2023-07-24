import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/haversine.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _category = [];
  List<Map<String, dynamic>> get category => _category;

  double? _currentLatitude;
  double? _currentLongitude;

  List<Map<String, dynamic>> _nearestSeller = [];
  List<Map<String, dynamic>> get nearestSeller => _nearestSeller;

  List<Map<String, dynamic>> _recommendedSeller = [];
  List<Map<String, dynamic>> get recommendedSeller => _recommendedSeller;

  Future<void> fetchCategories() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      if (snapshot.docs.isNotEmpty) {
        _category = snapshot.docs.map((doc) => doc.data()).toList();
      } else {
        _category = [];
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
    notifyListeners();
  }

  void updateLocation(double latitude, double longitude) {
    _currentLatitude = latitude;
    _currentLongitude = longitude;
  }

  Future<void> fetchNearestSellers() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('seller').get();
      if (snapshot.docs.isNotEmpty) {
        final sellers = snapshot.docs.map((doc) => doc.data()).toList();

        if (_currentLatitude == null || _currentLongitude == null) {
          // Handle if latitude and longitude are not available
          return;
        }

        sellers.sort((a, b) {
          final distanceA = Haversine.calculateDistance(
            _currentLatitude!,
            _currentLongitude!,
            a['location'].latitude,
            a['location'].longitude,
          );
          final distanceB = Haversine.calculateDistance(
            _currentLatitude!,
            _currentLongitude!,
            b['location'].latitude,
            b['location'].longitude,
          );
          return distanceA.compareTo(distanceB);
        });

        _nearestSeller = sellers;
      } else {
        _nearestSeller = [];
      }
    } catch (error) {
      print('Error fetching nearest sellers: $error');
    }
    notifyListeners();
  }

  Future<void> fetchRecommendedSellers() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('seller')
          .orderBy('rating', descending: true)
          .limit(5)
          .get();
      if (snapshot.docs.isNotEmpty) {
        _recommendedSeller = snapshot.docs.map((doc) => doc.data()).toList();
      } else {
        _recommendedSeller = [];
      }
    } catch (error) {
      print('Error fetching recommended sellers: $error');
    }
    notifyListeners();
  }
}
