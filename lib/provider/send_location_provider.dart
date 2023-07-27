import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendLocationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _sendLocation = [];
  List<Map<String, dynamic>> get sendLocation => _sendLocation;

  String _userUid = '';
  String get userUid => _userUid;

  Future<void> fetchSendLocation() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(_userUid)
        .collection('sendLocation')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.size > 0) {
        _sendLocation.clear();
        querySnapshot.docs.forEach((DocumentSnapshot document) {
          _sendLocation.add(document.data() as Map<String, dynamic>);
        });

        notifyListeners();
      } else {
        print('No data found in Firestore.');
      }
    }).catchError((error) {
      print('Error getting data from Firestore: $error');
    });
  }

  void getLoggedInUID() {
    User user = FirebaseAuth.instance.currentUser!;
    _userUid = user.uid;
    notifyListeners();
  }
}
