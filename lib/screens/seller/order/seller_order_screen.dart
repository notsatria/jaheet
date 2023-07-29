import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant/theme.dart';
import '../seller_main_screen.dart';
import 'seller_order_detail_screen.dart';

class SellerOrderScreen extends StatefulWidget {
  const SellerOrderScreen({super.key});

  @override
  State<SellerOrderScreen> createState() => _SellerOrderScreenState();
}

class _SellerOrderScreenState extends State<SellerOrderScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference seller = FirebaseFirestore.instance.collection('seller');
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  Future<List<Map<String, dynamic>>> getOrdersData() async {
    final uid = auth.currentUser!.uid;
    final sellerId =
        await users.doc(uid).get().then((value) => value.get('sellerId'));

    if (sellerId != null) {
      final orderSnapshot =
          await orders.where('sellerid', isEqualTo: sellerId).get();
      if (orderSnapshot.docs.isNotEmpty) {
        // Return a list of order data maps
        return orderSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      }
    }

    // If seller data is not found or no order data is found for the seller, return an empty List.
    return [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrdersData();
  }

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

    DateTime parseOrderDateString(String orderDateStr) {
      int year = int.parse(orderDateStr.substring(0, 4));
      int month = int.parse(orderDateStr.substring(4, 6));
      int day = int.parse(orderDateStr.substring(6, 8));
      int hour = int.parse(orderDateStr.substring(8, 10));
      int minute = int.parse(orderDateStr.substring(10, 12));
      int second = int.parse(orderDateStr.substring(12, 14));

      return DateTime(year, month, day, hour, minute, second);
    }

    String formatDateTime(DateTime dateTime) {
      // Use the intl package to format the date
      String formattedDate =
          DateFormat('MMMM dd, yyyy, h:mm a').format(dateTime);
      return formattedDate;
    }

    Widget cardPesananku(Map<String, dynamic> orderData) {
      String orderDateString = orderData['order-date'];
      DateTime orderDate = parseOrderDateString(orderDateString);
      String formattedDate = formatDateTime(orderDate);

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SellerOrderDetailScreen(
                orderData: orderData,
              ),
            ),
          );
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
                        orderData['kategori'],
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
                    'Order ID: ${orderData['orderid']}',
                    style: subtitleTextStyle.copyWith(fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    orderData['jenis'],
                    style: primaryTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 18,
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
                          formattedDate,
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
          child: FutureBuilder(
            future: getOrdersData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Text('Error fetching data');
              } else {
                final orderList = snapshot.data as List<Map<String, dynamic>>;
                if (orderList.isEmpty) {
                  return const Center(
                    child: Text('No orders found for this seller.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      return cardPesananku(orderList[index]);
                    },
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
