import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendLocationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _sendLocation = [];
  List<Map<String, dynamic>> get sendLocation => _sendLocation;

  String _selectedLocation = '';
  String get selectedLocation => _selectedLocation;

  String _userUid = '';
  String get userUid => _userUid;

  Future<void> fetchSendLocation() async {
    await getLoggedInUID();
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_userUid)
          .collection('sendLocation')
          .get();

      if (snapshot.docs.isNotEmpty) {
        _sendLocation = snapshot.docs.map((doc) => doc.data()).toList();

        int selectedLocationIndex = _sendLocation.indexWhere(
          (locationData) => locationData["isSelected"] == true,
        );

        if (selectedLocationIndex >= 0) {
          Map<String, dynamic> selectedLocation =
              _sendLocation[selectedLocationIndex];
          _sendLocation.removeAt(selectedLocationIndex);
          _sendLocation.insert(0, selectedLocation);

          _selectedLocation = selectedLocation["receiverName"];
          notifyListeners();
        } else {
          _selectedLocation = '';
        }
      } else {
        _sendLocation = [];
        _selectedLocation = '';
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> setSelectedLocation(
      Map<String, dynamic> selectedLocation) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userUid)
          .collection('sendLocation')
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) async {
          if (doc.data()["receiverName"] == selectedLocation["receiverName"]) {
            await doc.reference.update({"isSelected": true});
          } else {
            await doc.reference.update({"isSelected": false});
          }
        });
      });

      _selectedLocation = selectedLocation["receiverName"];
      await fetchSendLocation();
      notifyListeners();
    } catch (error) {
      print('Error updating selected location: $error');
    }
  }

  Future<void> addSendLocation(
    String type,
    String receiverName,
    String phoneNumber,
    String additionalInformation,
    String city,
    String province,
  ) async {
    await getLoggedInUID();
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userUid)
          .collection('sendLocation')
          .add({
        "type": type,
        "receiverName": receiverName,
        "phone": phoneNumber,
        "additionalDetail": additionalInformation,
        "city": city,
        "province": province,
        "isSelected": false,
      });
    } catch (error) {
      print('Error adding data: $error');
    }
  }

  Future<void> getLoggedInUID() async {
    User user = FirebaseAuth.instance.currentUser!;
    _userUid = user.uid;
  }
}
