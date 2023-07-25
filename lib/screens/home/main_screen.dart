import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jahitin/provider/location_provider.dart';
import 'package:jahitin/screens/home/location_recommendation.dart';
import 'package:provider/provider.dart';

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
        extendBody: true,
        resizeToAvoidBottomInset: false,
        floatingActionButton: locationButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          activeColor: primaryColor,
          inactiveColor: Colors.grey,
          height: kBottomNavigationBarHeight + 20,
          iconSize: 28,
          icons: [
            currIndex == 0 ? Icons.home : Icons.home_outlined,
            currIndex == 1 ? Icons.library_books : Icons.library_books_outlined,
            currIndex == 2 ? Icons.chat : Icons.chat_outlined,
            currIndex == 3 ? Icons.person : Icons.person_outlined,
          ],
          activeIndex: currIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) => setState(() => currIndex = index),
          //other params
        ),
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

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    context.read<LocationProvider>().setLat(position.latitude);
    context.read<LocationProvider>().setLong(position.longitude);

    setState(() {
      longitude = position.longitude;
      latitude = position.latitude;
    });
  }
}
