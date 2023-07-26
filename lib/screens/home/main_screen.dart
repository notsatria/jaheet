import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jahitin/provider/location_provider.dart';
import 'package:jahitin/screens/home/location_recommendation.dart';
import 'package:provider/provider.dart';

import '../../constant/theme.dart';
import '../../provider/home_screen_provider.dart';
import 'chat_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'transaction_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currIndex = 0;

  // Location
  late double longitude;
  late double latitude;

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position.longitude);
    print(position.latitude);

    context.read<LocationProvider>().setLat(position.latitude);
    context.read<LocationProvider>().setLong(position.longitude);

    context.read<HomeScreenProvider>().updateLocation(
          position.latitude,
          position.longitude,
        );

    setState(() {
      longitude = position.longitude;
      latitude = position.latitude;
    });

    context.read<HomeScreenProvider>().fetchCategories();
    context.read<HomeScreenProvider>().fetchNearestSellers();
    context.read<HomeScreenProvider>().fetchRecommendedSellers();
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void dispose() {
    getLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget locationButton() {
      return Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white, // Warna outline putih
            width: 10.0, // Lebar outline
          ),
        ),
        child: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: () {
            Navigator.pushNamed(context, LocationRecommendationScreen.routeName,
                arguments: {'longitude': longitude, 'latitude': latitude});
          },
          child: Icon(
            Icons.location_on,
            color: backgroundColor1,
          ),
        ),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            selectedItemColor: primaryColor,
            currentIndex: currIndex,
            onTap: (value) {
              setState(() {
                currIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: backgroundColor1,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Icon(
                    currIndex == 0 ? Icons.home : Icons.home_outlined,
                    color: primaryColor,
                    size: 28,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Icon(
                    currIndex == 1
                        ? Icons.library_books
                        : Icons.library_books_outlined,
                    color: primaryColor,
                    size: 28,
                  ),
                ),
                label: 'Transaction',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Icon(
                    currIndex == 2 ? Icons.chat : Icons.chat_outlined,
                    color: primaryColor,
                    size: 28,
                  ),
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Icon(
                    currIndex == 3 ? Icons.person : Icons.person_outlined,
                    color: primaryColor,
                    size: 28,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      switch (currIndex) {
        case 0:
          return const HomeScreen();

        case 1:
          return const TransactionScreen();

        case 2:
          return const ChatScreen();

        case 3:
          return const ProfileScreen();

        default:
          return const HomeScreen();
      }
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: locationButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: customBottomNav(),
        body: Column(
          children: [
            Expanded(
              child: body(),
            ),
          ],
        ),
      ),
    );
  }
}
