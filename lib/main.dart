import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jahitin/provider/detail_screen_provider.dart';
import 'package:jahitin/provider/home_screen_provider.dart';
import 'package:jahitin/screens/splash_screen.dart';
import 'package:jahitin/screens/seller/registration_form_screen.dart';
import 'package:jahitin/screens/seller/seller_main_screen.dart';
import 'package:jahitin/screens/transaction/service_screen.dart';
import 'package:provider/provider.dart';

import 'provider/google_sign_in_provider.dart';
import 'provider/location_provider.dart';
import 'screens/home/detail_screen.dart';
import 'screens/home/edit_profile_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/location_recommendation.dart';
import 'screens/home/main_screen.dart';
import 'screens/home/profile_screen.dart';
import 'screens/home/search_screen.dart';
import 'screens/home/transaction_detail_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/slide_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await checkPermission();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => DetailScreenProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      routes: {
        '/': (context) => const SplashScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailScreen.routeName: (context) => const DetailScreen(),
        ServiceScreen.routeName: (context) => const ServiceScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
        SlideScreen.routeName: (context) => const SlideScreen(),
        TransactionDetailScreen.routeName: (context) =>
            const TransactionDetailScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        EditProfileScreen.routeName: (context) => const EditProfileScreen(),
        LocationRecommendationScreen.routeName: (context) =>
            const LocationRecommendationScreen(),
        SellerMainScreen.routeName: (context) => const SellerMainScreen(),
        RegistrationFormScreen.routeName: (context) =>
            const RegistrationFormScreen()
      },
    );
  }
}

Future<void> checkPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
    } else if (permission == LocationPermission.deniedForever) {
      print("'Location permissions are permanently denied");
    } else {
      print("GPS Location service is granted");
    }
  } else {
    print("GPS Location permission granted.");
  }
}
