import 'package:flutter/material.dart';

import '../../constant/theme.dart';
import 'main_screen.dart';

class AddLocationScreen extends StatelessWidget {
  const AddLocationScreen({super.key});

  static const routeName = "/add-location-dart";

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Tambahkan Alamat',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: semiBold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
          ),
        ),
        elevation: 2,
      );
    }

    return Scaffold(
      appBar: appBar(),
    );
  }
}
