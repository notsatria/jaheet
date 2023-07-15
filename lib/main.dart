import 'package:flutter/material.dart';
import 'package:jahitin/screens/home/chatroom_screen.dart';
import 'package:jahitin/screens/home/checkout_screen.dart';
import 'package:jahitin/screens/home/home_screen.dart';
import 'package:jahitin/screens/home/search_screen.dart';
import 'package:jahitin/screens/home/detail_screen.dart';

import 'screens/home/main_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ChatRoomScreen.routeName: (context) => const ChatRoomScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        CheckoutScreen.routeName: (context) => const CheckoutScreen(),
      },
    );
  }
}
