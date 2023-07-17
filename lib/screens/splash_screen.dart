import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jahitin/screens/home/main_screen.dart';

import '../constant/theme.dart';
import 'slide_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // cek apakah user sudah login/ belum
  // jika sudah login maka akan diarahkan ke home screen
  // jika belum login maka akan diarahkan ke sign in screen

  @override
  void initState() {
    // TODO: implement initState
    Future<void> checkLoginStatus() async {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final googleSignIn = GoogleSignIn();

      if (await googleSignIn.isSignedIn()) {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, MainScreen.routeName);
        });
      } else {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, SlideScreen.routeName);
        });
      }

      if (user != null) {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, MainScreen.routeName);
        });
      } else {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, SlideScreen.routeName);
        });
      }
    }

    checkLoginStatus();
    super.initState();
  }

  Widget jahitinLogo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon/jaheetlogo.png',
            width: 200,
            height: 200,
          ),
          Text(
            'Jaheet',
            style: primaryTextStyle.copyWith(
              fontSize: 32,
              fontWeight: semiBold,
              color: backgroundColor1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: jahitinLogo(),
    );
  }
}
