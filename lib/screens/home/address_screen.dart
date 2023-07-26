import 'package:flutter/material.dart';

import '../../constant/theme.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});
  static const routeName = 'address-screen';

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Alamat',
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
        elevation: 2,
      );
    }

    return Scaffold(
      appBar: appBar(),
    );
  }
}
