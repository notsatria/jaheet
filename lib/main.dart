import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jahitin/provider/address_screen_provider.dart';
import 'package:jahitin/provider/checkout_screen_provider.dart';
import 'package:jahitin/provider/detail_screen_provider.dart';
import 'package:jahitin/provider/home_screen_provider.dart';
import 'package:jahitin/provider/search_screen_provider.dart';
import 'package:jahitin/screens/home/address_screen.dart';
import 'package:jahitin/screens/home/edit_location.dart';
import 'package:jahitin/screens/home/see_more.dart';
import 'package:jahitin/screens/home/transaction_screen.dart';
import 'package:jahitin/screens/splash_screen.dart';
import 'package:jahitin/provider/send_location_provider.dart';
import 'package:jahitin/screens/home/add_location.dart';
import 'package:jahitin/screens/seller/order/seller_order_screen.dart';
import 'package:jahitin/screens/seller/products/add_product_screen.dart';
import 'package:jahitin/screens/seller/registration_form_screen.dart';
import 'package:jahitin/screens/seller/seller_main_screen.dart';
import 'package:jahitin/screens/transaction/checkout_screen.dart';
import 'package:jahitin/screens/transaction/payment_screen.dart';
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
import 'screens/transaction/delivery_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await checkPermission();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => DetailScreenProvider()),
        ChangeNotifierProvider(create: (_) => SearchScreenProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutScreenProvider()),
        ChangeNotifierProvider(create: (_) => AddressScreenProvider()),
        ChangeNotifierProvider(create: (_) => SendLocationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        DeliveryScreen.routeName: (context) => const DeliveryScreen(),
        PaymentScreen.routeName: (context) => const PaymentScreen(),
        SlideScreen.routeName: (context) => const SlideScreen(),
        CheckoutScreen.routeName: (context) => const CheckoutScreen(),
        TransactionScreen.routeName: (context) => const TransactionScreen(),
        TransactionDetailScreen.routeName: (context) =>
            const TransactionDetailScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        EditProfileScreen.routeName: (context) => const EditProfileScreen(),
        LocationRecommendationScreen.routeName: (context) =>
            const LocationRecommendationScreen(),
        SellerMainScreen.routeName: (context) => const SellerMainScreen(),
        SellerOrderScreen.routeName: (context) => const SellerOrderScreen(),
        RegistrationFormScreen.routeName: (context) =>
            const RegistrationFormScreen(),
        AddProductScreen.routeName: (context) => const AddProductScreen(),
        AddLocationScreen.routeName: (context) => const AddLocationScreen(),
        EditLocationScreen.routeName: (context) => const EditLocationScreen(),
        AddressScreen.routeName: (context) => const AddressScreen(),
        SeeMoreScreen.routeName: (context) => const SeeMoreScreen()
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
