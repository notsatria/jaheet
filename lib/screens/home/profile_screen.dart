import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jahitin/constant/theme.dart';
import 'package:jahitin/provider/google_sign_in_provider.dart';
import 'package:jahitin/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

import '../seller/registration_form_screen.dart';
import '../seller/seller_main_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _googleSignIn = GoogleSignIn();
  final user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String? uid;
  bool isGoogleUser = false;
  bool isDataLoaded = false;

  Future<void> loadUser() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      setState(() {
        uid = firebaseUser.uid;
        isGoogleUser = false;
        isDataLoaded = true;
      });
    } else {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        setState(() {
          uid = googleUser.id;
          isGoogleUser = true;
          isDataLoaded = true;
        });
      } else {
        setState(() {
          uid = null;
          isGoogleUser = false;
          isDataLoaded = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    Widget profileHeader(
        {required photoURL, required String name, required String email}) {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              photoURL,
            ),
          ),
          title: Text(
            name,
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          subtitle: Text(
            email,
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
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogout();
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            },
          ),
        ),
      );
    }

    Future<Widget> googleProfileHeader() async {
      final googleUser = await _googleSignIn.signIn();
      return profileHeader(
        photoURL: googleUser!.photoUrl,
        name: googleUser.displayName ?? '',
        email: googleUser.email,
      );
    }

    Widget accountProfileBlock() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                'Akun Saya',
                style: primaryTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, EditProfileScreen.routeName);
              },
              child: const ListTile(
                leading: Text(
                  'Edit Profil',
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final isSeller = await users.doc(uid).get().then((value) {
                  return value.get('isSeller');
                });
                if (isSeller == true) {
                  Navigator.pushNamed(context, SellerMainScreen.routeName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: primaryColor,
                      content: Text(
                        'Selamat Datang Penjahit',
                        style: whiteTextStyle.copyWith(
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  );
                } else {
                  Navigator.pushNamed(
                      context, RegistrationFormScreen.routeName);
                  // scaffold messanger
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: alertColor,
                      content: Text(
                        'Anda belum terdaftar sebagai penjahit',
                        style: whiteTextStyle.copyWith(
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  );
                }
              },
              child: const ListTile(
                leading: Text(
                  'Penjaheet',
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
                  'Favorit Saya',
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
            child: Column(
              children: [
                isDataLoaded
                    ? (isGoogleUser
                        ? FutureBuilder(
                            future: googleProfileHeader(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else {
                                return snapshot.data ??
                                    const Text('Google user not signed in');
                              }
                            },
                          )
                        : FutureBuilder(
                            future: users.doc(uid).get(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return profileHeader(
                                  photoURL: snapshot.data!.get('photoURL'),
                                  name: snapshot.data!.get('name'),
                                  email: snapshot.data!.get('email'),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ))
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                accountProfileBlock(),
                generalProfileBlock(),
              ],
            ),
          )),
    );
  }
}
