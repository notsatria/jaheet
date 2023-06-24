import 'dart:async';

import 'package:flutter/material.dart';

import '../constant/theme.dart';
import 'sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, SignInScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
          child: Text(
        'Jahitin',
        style: primaryTextStyle.copyWith(
            fontSize: 32, fontWeight: semiBold, color: backgroundColor1),
      )),
    );
  }
}
