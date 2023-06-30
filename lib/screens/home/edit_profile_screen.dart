import 'package:flutter/material.dart';

import '../../constant/theme.dart';

class EditProfileScreen extends StatelessWidget {
  static const routeName = '/edit-profile';
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: semiBold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check,
              color: primaryColor,
            ),
          ),
        ],
        elevation: 2,
      );
    }

    Widget profileImageEdit() {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: Center(
          child: Stack(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=12',
                ),
              ),
              Positioned(
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt,
                      color: backgroundColor1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget editInputField(
        {required String title, required String initialValue}) {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: TextFormField(
          initialValue: initialValue,
          cursorColor: primaryColor,
          style: primaryTextStyle,
          decoration: InputDecoration(
            labelText: title,
            labelStyle: subtitleTextStyle.copyWith(
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              profileImageEdit(),
              editInputField(
                title: 'Nama',
                initialValue: 'Muhammad Fadli',
              ),
              editInputField(title: 'Username', initialValue: '@muhammadfadli'),
              editInputField(
                  title: 'Email', initialValue: 'muhammadfadli@gmail.com')
            ],
          ),
        ),
      ),
    );
  }
}
