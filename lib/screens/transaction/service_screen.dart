import 'package:flutter/material.dart';

import '../../constant/theme.dart';

class ServiceScreen extends StatefulWidget {
  static const routeName = '/service-screen';
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: backgroundColor1,
      title: Text(
        'Pilih Jasa',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
    );
  }
}
