import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  double _lat = 0;
  double _long = 0;

  void setLat(double newLat) {
    _lat = newLat;
    notifyListeners();
  }

  void setLong(double newLong) {
    _long = newLong;
    notifyListeners();
  }

  double get lat => _lat;
  double get long => _long;
}
