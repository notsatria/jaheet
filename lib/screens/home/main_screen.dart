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
