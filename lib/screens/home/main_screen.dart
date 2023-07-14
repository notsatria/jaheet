import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jahitin/screens/home/location_recommendation.dart';

import '../../constant/theme.dart';
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
  double longitude = 0;
  double latitude = 0;

  @override
  void initState() {
    super.initState();
    checkPermission();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    Widget locationButton() {
      return FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
          Navigator.pushNamed(context, LocationRecommendationScreen.routeName,
              arguments: {'longitude': longitude, 'latitude': latitude});
        },
        child: Icon(
          Icons.location_on,
          color: backgroundColor1,
        ),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 12.0,
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
            backgroundColor: backgroundColor4,
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
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
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

  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print("'Location permissions are permanently denied");
      } else {
        print("GPS Location service is granted");
      }
    } else {
      print("GPS Location permission granted.");
    }
  }

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    setState(() {
      longitude = position.longitude;
      latitude = position.latitude;
    });
  }
}
