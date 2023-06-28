import 'package:flutter/material.dart';

import '../../constant/theme.dart';
import 'main_screen.dart';
import 'transaction_detail_screen.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Riwayat Transaksi',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: semiBold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, MainScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
          ),
        ),
        elevation: 2,
      );
    }

    Widget transactionItem() {
      return Card(
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, TransactionDetailScreen.routeName);
          },
          leading: Image.asset('assets/images/kerah.png'),
          title: Text(
            'Menjahit Kerah',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
          subtitle: Text(
            'Sen, 8 Juni 2023',
            style: secondaryTextStyle.copyWith(fontSize: 14),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: primaryTextColor,
          ),
        ),
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
            children: [
              transactionItem(),
              transactionItem(),
              transactionItem(),
            ],
          ),
        ),
      ),
    );
  }
}
