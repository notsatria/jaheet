import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/screens/home/main_screen.dart';

import '../../../constant/theme.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
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

  Future<void> getSellerData() async {
    final uid = auth.currentUser!.uid;
    final userData =
        await users.doc(uid).get().then((value) => value.get('sellerId'));

    print(userData);

    if (userData != null) {
      final sellerSnapshot = await seller.doc('$userData').get();

      print(sellerSnapshot.id);

      if (sellerSnapshot.exists) {
        setState(() {
          tokoName = sellerSnapshot.get('name');
          tokoImageProfile = sellerSnapshot.get('profileImage');
          tokoAddress = sellerSnapshot.get('address');
          tokoDescription = sellerSnapshot.get('description');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget profileHeader() {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/jaheet-5fa13.appspot.com/o/seller_profile_images%2Fseller_profile_image_7.png?alt=media',
            ),
          ),
          title: Text(
            tokoName,
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          subtitle: Text(
            tokoAddress,
            style: subtitleTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: alertColor,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, MainScreen.routeName);
            },
          ),
        ),
      );
    }

    Widget accountProfileBlock() {
      return Container(
        margin: const EdgeInsets.only(top: 40),
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
                getSellerData();
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
            GestureDetector(
              onTap: () {
                //
              },
              child: const ListTile(
                leading: Text(
                  'Help',
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
                //
              },
              child: const ListTile(
                leading: Text(
                  'Terms of Service',
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
                  'Rate App',
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

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(children: [
            profileHeader(),
            accountProfileBlock(),
            generalProfileBlock(),
          ]),
        ),
      ),
    );
  }
}
