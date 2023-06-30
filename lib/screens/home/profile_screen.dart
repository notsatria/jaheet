import 'package:flutter/material.dart';
import 'package:jahitin/constant/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget profileHeader() {
      return ListTile(
        leading: const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/150?img=12',
          ),
        ),
        title: Text(
          'Muhammad Fadli',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
        subtitle: Text(
          'muhammadfadli@gmail.com',
          style: subtitleTextStyle,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: alertColor,
          ),
          onPressed: () {
            //
          },
        ),
      );
    }

    Widget accountProfileBlock() {
      return Column(
        children: [
          Text(
            'Akun Saya',
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              //
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
      );
    }

    Widget generalProfileBlock() {
      return Column(
        children: [
          Text(
            'General',
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
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
      );
    }

    return SafeArea(
      child: Scaffold(
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
