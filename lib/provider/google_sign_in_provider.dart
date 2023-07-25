import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      // if (googleUser != null) return;

      print(googleUser);

      _user = googleUser;

      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'sign_in_canceled') {
          // User canceled the sign-in process
        } else {
          // Handle other errors
        }
      } else {
        // Handle other errors
      }
    }

    notifyListeners();
  }

  Future googleLogout() async {
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
    }
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<void> addUserToFirestoreFromGoogle() async {
    final googleUser = await googleSignIn.signIn();
    final user = FirebaseAuth.instance.currentUser;

    final email = googleUser!.email;
    final name = googleUser.displayName;
    final String? uid;
    if (user != null) {
      uid = user.uid;
    } else {
      uid = googleUser.id;
    }
    final photoURL = googleUser.photoUrl;
    final newUser = {
      'uid': uid,
      'name': name,
      'isSeller': false,
      'email': email,
      'photoURL': photoURL ?? 'https://i.stack.imgur.com/l60Hf.png',
    };
    // cek apakah user sudah mendaftar atau belum
    final userDoc = await users.doc(uid).get();
    if (userDoc.exists) {
      print('User already exists');
      return;
    }
    try {
      await users.doc(uid).set(newUser);
      print('User Added');
    } catch (error) {
      print('Failed to add user: $error');
    }
    notifyListeners();
  }

  Future<bool> isUserLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
