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

    Widget namaTokoForm() {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor4,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Nama Toko',
                  hintStyle: TextStyle(
                    color: subtitleTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget form() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [namaTokoForm(), namaTokoForm()],
        ),
      );
    }

    return Scaffold(appBar: appBar(), body: form());
  }
}
