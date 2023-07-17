import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/constant/theme.dart';
import 'package:jahitin/provider/google_sign_in_provider.dart';
import 'package:jahitin/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    Widget profileHeader() {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              user.photoURL ?? 'https://i.stack.imgur.com/l60Hf.png',
            ),
          ),
          title: Text(
            user.displayName ?? 'null',
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          subtitle: Text(
            user.email ?? 'null',
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
              onTap: () {
                //
              },
              child: const ListTile(
                leading: Text(
                  'Buka Jasa Jahit',
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
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              children: [
                profileHeader(),
                accountProfileBlock(),
                generalProfileBlock(),
              ],
            ),
          )),
    );
  }
}
