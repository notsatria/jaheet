import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/provider/transaction_screen_provider.dart';
import 'package:jahitin/screens/home/main_screen.dart';
import 'package:jahitin/screens/seller/featured_seller_form_registration_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/theme.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference seller = FirebaseFirestore.instance.collection('seller');

  String tokoName = '';
  String tokoImageProfile = '';
  String tokoAddress = '';
  String tokoDescription = '';

  @override
  void initState() {
    super.initState();
    getSellerData();
  }

  // Future<void> getSellerData() async {
  //   final uid = auth.currentUser!.uid;
  //   final userData =
  //       await users.doc(uid).get().then((value) => value.get('sellerId'));

  //   print(userData);

  //   if (userData != null) {
  //     final sellerSnapshot = await seller.doc('$userData').get();

  //     print(sellerSnapshot.id);

  //     if (sellerSnapshot.exists) {
  //       setState(() {
  //         tokoName = sellerSnapshot.get('name');
  //         tokoImageProfile = sellerSnapshot.get('profileImage');
  //         tokoAddress = sellerSnapshot.get('address');
  //         tokoDescription = sellerSnapshot.get('description');
  //       });
  //     }
  //   }
  // }

  Future<Map<String, dynamic>> getSellerData() async {
    final uid = auth.currentUser!.uid;
    final userData =
        await users.doc(uid).get().then((value) => value.get('sellerId'));

    if (userData != null) {
      final sellerSnapshot = await seller.doc('$userData').get();
      if (sellerSnapshot.exists) {
        return sellerSnapshot.data() as Map<String, dynamic>;
      }
    }

    // If seller data is not found, return an empty Map or null.
    return {};
  }

  @override
  Widget build(BuildContext context) {
    Widget sellerProfileHeader(
        {String? profileImage, String? tokoName, required bool tokoStatus}) {
      return Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(
                  profileImage ?? 'https://i.stack.imgur.com/l60Hf.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: defaultMargin, vertical: defaultMargin / 2),
            width: double.infinity,
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tokoName ?? 'Toko Name',
                  style: whiteTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text(
                      'Toko Penjahit',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    tokoStatus
                        ? const Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 16,
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget featuredServices(
      String layanan,
      int totalOrder,
      String image,
    ) {
      return SizedBox(
        width: 75,
        height: 100,
        child: Column(
          children: [
            Image.asset(
              image,
              width: 45,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              layanan,
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Total order: ',
                style: primaryTextStyle.copyWith(
                  fontSize: 11,
                ),
                children: [
                  TextSpan(
                    text: totalOrder.toString(),
                    style: secondaryTextStyle,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget categoryPenjahit() {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ABOUT SELLER',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                featuredServices(
                  'ATASAN',
                  120,
                  'assets/icon/shirt.png',
                ),
                featuredServices(
                  'BAWAHAN',
                  67,
                  'assets/icon/jeans.png',
                ),
                featuredServices(
                  'TERUSAN',
                  12,
                  'assets/icon/dress.png',
                ),
                featuredServices(
                  'PERBAIKAN',
                  6,
                  'assets/icon/sewing.png',
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget accountProfileBlock() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                'Akun Penjaheet',
                style: primaryTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //
              },
              child: const ListTile(
                leading: Text(
                  'Edit Profil Penjaheet',
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //
              },
              child: const ListTile(
                leading: Text(
                  'Produk Saya',
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget generalProfileBlock() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                'General',
                style: primaryTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //
              },
              child: const ListTile(
                leading: Text(
                  'Privacy & Policy',
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MainScreen.routeName);
              },
              child: const ListTile(
                leading: Text(
                  'Keluar',
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget registerToFeaturedSeller(String id) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
          onPressed: () {
            context.read<TransactionScreenProvider>().setSellerId(id);
            print(context.read<TransactionScreenProvider>().sellerId);
            Navigator.pushNamed(
                context, FeaturedSellerFormRegistration.routeName);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.stars_rounded),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Daftar Penjaheet Premium",
                  style: primaryTextStyle.copyWith(
                    color: backgroundColor1,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<Map<String, dynamic>>(
                  future: getSellerData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          sellerProfileHeader(
                              profileImage: snapshot.data!['profileImage'],
                              tokoName: snapshot.data!['name'],
                              tokoStatus: snapshot.data!['isFeaturedSeller']),
                          snapshot.data!['isFeaturedSeller']
                              ? const SizedBox()
                              : registerToFeaturedSeller(
                                  snapshot.data!['id'].toString()),
                        ],
                      );
                    } else {
                      // Handle the case when seller data is not available.
                      return const Center(
                        child: Text('Seller data not found.'),
                      );
                    }
                  },
                ),
                categoryPenjahit(),
                accountProfileBlock(),
                generalProfileBlock(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
