import 'package:flutter/material.dart';

import '../../constant/theme.dart';

class TransactionPaymentScreen extends StatelessWidget {
  static const routeName = '/transaction-payment-screen';
  const TransactionPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Pilih Metode Pembayaran',
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

    Widget pembayaranInstan() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Pembayaran Instan',
            style: TextStyle(
              color: primaryTextColor,
              fontWeight: medium,
              fontSize: 16,
            ),
          ),
          ListTile(
            onTap: () {
              //
            },
            leading: Image.asset(
              'assets/icon/ovo.png',
              width: 36,
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'OVO',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
          ListTile(
            onTap: () {
              //
            },
            leading: Image.asset(
              'assets/icon/gopay.png',
              width: 60,
            ),
            title: Text(
              'Gopay',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
          ListTile(
            onTap: () {
              //
            },
            leading: Image.asset(
              'assets/icon/dana.png',
              width: 40,
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Dana',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
          const Divider(
            thickness: 5,
          )
        ],
      );
    }

    Widget kartuKredit() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Kartu Kredit',
            style: TextStyle(
              color: primaryTextColor,
              fontWeight: medium,
              fontSize: 16,
            ),
          ),
          ListTile(
            onTap: () {
              //
            },
            leading: Icon(
              Icons.payment_rounded,
              size: 36,
              color: primaryColor,
            ),
            title: Text(
              'Kartu Kredit/ Cicilan',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
          const Divider(
            thickness: 5,
          )
        ],
      );
    }

    Widget virtualAccount() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Virtual Account',
            style: TextStyle(
              color: primaryTextColor,
              fontWeight: medium,
              fontSize: 16,
            ),
          ),
          ListTile(
            onTap: () {
              //
            },
            leading: Image.asset(
              'assets/icon/mandiri.png',
              width: 40,
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Mandiri Virtual Account',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
          ListTile(
            onTap: () {
              //
            },
            leading: Image.asset(
              'assets/icon/bca.png',
              width: 40,
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'BCA Virtual Account',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
          ListTile(
            onTap: () {
              //
            },
            leading: Image.asset(
              'assets/icon/briva.png',
              width: 40,
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'BRI Virtual Account',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
          ListTile(
            onTap: () {
              //
            },
            leading: Image.asset(
              'assets/icon/bni.png',
              width: 40,
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'BNI Virtual Account',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
          const Divider(
            thickness: 5,
          )
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              pembayaranInstan(),
              kartuKredit(),
              virtualAccount(),
            ],
          ),
        ),
      ),
    );
  }
}
