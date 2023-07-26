import 'package:flutter/material.dart';
import 'package:jahitin/screens/seller/seller_main_screen.dart';

import '../../../constant/theme.dart';
import 'seller_order_detail_screen.dart';

class SellerOrderScreen extends StatelessWidget {
  const SellerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Pesananku',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: semiBold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SellerMainScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
          ),
        ),
        elevation: 2,
      );
    }

    Widget cardPesananku() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, SellerOrderDetailScreen.routeName);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 6),
          child: Card(
            elevation: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'ATASAN',
                        style: primaryTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Jahit Termasuk Bahan',
                        style: subtitleTextStyle.copyWith(
                          fontWeight: reguler,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Text(
                    'Order ID: 1234567890',
                    style: subtitleTextStyle.copyWith(fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Baju Kemeja',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tanggal: 12/12/2021',
                          style: subtitleTextStyle,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ClipRRect(
                          child: Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Menunggu Konfirmasi',
                              style: primaryTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 12,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: ListView(
              children: [
                cardPesananku(),
                cardPesananku(),
              ],
            )),
      ),
    );
  }
}
