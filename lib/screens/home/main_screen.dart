import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jahitin/provider/location_provider.dart';
import 'package:jahitin/provider/send_location_provider.dart';
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

  Future<void> getLocation(LocationProvider locationProvider,
      HomeScreenProvider homeScreenProvider) async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    locationProvider.setLat(position.latitude);
    locationProvider.setLong(position.longitude);
    homeScreenProvider.updateLocation(
      position.latitude,
      position.longitude,
    );

    homeScreenProvider.fetchCategories();
    homeScreenProvider.fetchNearestSellers();
    homeScreenProvider.fetchRecommendedSellers();
  }

  @override
  void initState() {
    super.initState();
    getLocation(
        context.read<LocationProvider>(), context.read<HomeScreenProvider>());
    context.read<SendLocationProvider>().fetchSendLocation();
    context.read<SendLocationProvider>().fetchSelectionListSendLocation();
    context.read<SendLocationProvider>().fetchMapSelectedSendLocation();
  }

  @override
  void deactivate() {
    getLocation(
        context.read<LocationProvider>(), context.read<HomeScreenProvider>());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget locationButton() {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white, // Warna outline putih
            // Lebar outline
          ),
        ),
        child: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: () {
            Navigator.pushNamed(context, LocationRecommendationScreen.routeName,
                arguments: {
                  'longitude':
                      Provider.of<LocationProvider>(context, listen: false).lat,
                  'latitude':
                      Provider.of<LocationProvider>(context, listen: false).long
                });
          },
          child: Icon(
            Icons.location_on,
            color: backgroundColor1,
          ),
        ),
      );
    }

    Widget customBottomNav() {
      return AnimatedBottomNavigationBar(
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
      );
    }

    Widget body() {
      switch (currIndex) {
        case 0:
          return const HomeScreen();

        case 1:
          return TransactionScreen();

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
