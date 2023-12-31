import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/screens/seller/products/add_product_screen.dart';
import 'package:jahitin/screens/seller/profile/seller_profile_screen.dart';

import '../../constant/theme.dart';
import 'chat/seller_chat_screen.dart';
import 'home/seller_home_screen.dart';
import 'order/seller_order_screen.dart';

class SellerMainScreen extends StatefulWidget {
  static const routeName = '/seller-main-screen';
  const SellerMainScreen({super.key});

  @override
  State<SellerMainScreen> createState() => SellerMainScreenState();
}

class SellerMainScreenState extends State<SellerMainScreen> {
  int currIndex = 0;

  Widget addProductButton() {
    return FloatingActionButton(
      backgroundColor: secondaryColor,
      onPressed: () {
        Navigator.pushNamed(context, AddProductScreen.routeName);
      },
      child: Icon(
        Icons.add,
        color: backgroundColor1,
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
        currIndex == 0 ? Icons.dashboard_rounded : Icons.dashboard_outlined,
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
        return const SellerHomeScreen();

      case 1:
        return const SellerOrderScreen();

      case 2:
        return const SellerChatScreen();

      case 3:
        return const SellerProfileScreen();

      default:
        return const SellerHomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButton: addProductButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: Column(
        children: [
          Expanded(
            child: body(),
          ),
        ],
      ),
    );
  }
}
