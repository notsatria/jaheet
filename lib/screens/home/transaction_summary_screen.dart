import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/theme.dart';
import '../../provider/checkout_screen_provider.dart';
import 'main_screen.dart';

class TransactionSummaryScreen extends StatelessWidget {
  static const routeName = '/transaction-summary-screen';
  const TransactionSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Ringkasan Transaksi',
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

    Widget transactionSummary() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'Total Tagihan',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              trailing: Text(
                'Rp ${context.read<CheckoutScreenProvider>().getTotalTagihan}',
                style: secondaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget paymentMethod() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 15),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'BNI Virtual Account',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              trailing: Image.asset(
                'assets/icon/bni.png',
                width: 40,
              ),
            ),
          ),
        ),
      );
    }

    Widget paymentCode() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 15),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'Kode Bayar',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    '9908 1234 5678 9012',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.copy,
                        color: subtitleTextColor,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Salin',
                        style: subtitleTextStyle.copyWith(
                            color: subtitleTextColor, fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget cekPayment() {
      return GestureDetector(
        onTap: () {
          //TODO
          // Consumer<TransactionScreenProvider>(
          //   builder: (context, transactionScreenProvider, _) {
          //     final detaildata = transactionScreenProvider.detailScreenData;
          //     final orderid = detaildata?['orderid'];

          //     transactionScreenProvider.sendTotalTagihan(
          //         context.read<CheckoutScreenProvider>().getTotalTagihan,
          //         orderid);

          //     return const Text('Berhasil');
          //   },
          // );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                insetPadding: const EdgeInsets.all(90),
                content: SizedBox(
                  height: 128,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 60,
                        color: Colors.greenAccent,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Pembayaran Berhasil',
                        style: primaryTextStyle,
                      )
                    ],
                  ),
                ),
              );
            },
          );
          Timer(const Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(
              context,
              MainScreen.routeName,
            );
          });
        },
        child: Container(
          height: 60,
          width: double.maxFinite,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'Cek Pembayaran',
              style: primaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: cekPayment(),
        ),
        appBar: appBar(),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            children: [
              transactionSummary(),
              paymentMethod(),
              paymentCode(),
            ],
          ),
        ),
      ),
    );
  }
}
