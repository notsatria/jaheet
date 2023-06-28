import 'dart:async';

import 'package:flutter/material.dart';

import '../constant/theme.dart';
import 'slide_screen.dart';

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
      Navigator.pushReplacementNamed(context, SlideScreen.routeName);
    });
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
