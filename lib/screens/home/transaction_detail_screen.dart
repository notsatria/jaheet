import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../../constant/theme.dart';

class TransactionDetailScreen extends StatelessWidget {
  static const routeName = '/transaction-screen';

  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Detail Transaksi',
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

    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
