import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jahitin/constant/theme.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({super.key});

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
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

  int totalOrders = 0;
  int potentialPrice = 0;
  int ordersDone = 0;
  int ordersProcessed = 0;

  Future<void> getTotalOrders() async {
    List<Map<String, dynamic>> ordersData = await getOrdersData();
    setState(() {
      totalOrders = ordersData.length;
    });
  }

  Future<void> getPotentialPrice() async {
    List<Map<String, dynamic>> ordersData = await getOrdersData();
    for (int i = 0; i < ordersData.length; i++) {
      setState(() {
        potentialPrice += int.parse(ordersData[i]['harga_maksimal']);
      });
    }
  }

  Future<void> getOrdersDone() async {
    List<Map<String, dynamic>> ordersData = await getOrdersData();
    for (int i = 0; i < ordersData.length; i++) {
      if (ordersData[i]['order_status'] == 'Selesai') {
        setState(() {
          ordersDone += 1;
        });
      }
    }
  }

  Future<void> getOrdersOnProcess() async {
    List<Map<String, dynamic>> ordersData = await getOrdersData();
    for (int i = 0; i < ordersData.length; i++) {
      if (ordersData[i]['order_status'] == 'Diproses') {
        setState(() {
          ordersProcessed += 1;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalOrders();
    getPotentialPrice();
    getOrdersDone();
    getOrdersOnProcess();
  }

  @override
  Widget build(BuildContext context) {
    Widget helloSeller() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Text(
          'Hello, Penjaheet!',
          style: primaryTextStyle.copyWith(
            fontSize: 24,
            fontWeight: bold,
          ),
        ),
      );
    }

    Widget cardPesananMasuk(int total, int potentialPrice) {
      final formattedPotentialPrice =
          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
              .format(potentialPrice);
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan Masuk',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$total',
                  style: primaryTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Potensi:',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '+$formattedPotentialPrice',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.bar_chart_rounded,
              size: 50,
              color: secondaryColor,
            ),
          ],
        ),
      );
    }

    Widget cardPesananSelesai(int ordersDone) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan Selesai',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$ordersDone',
                  style: primaryTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Keuntungan:',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Rp 1.000.000',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.monetization_on_rounded,
              size: 50,
              color: secondaryColor,
            ),
          ],
        ),
      );
    }

    Widget cardPesananDiproses(int ordersProcessed) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan Dalam Proses',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$ordersProcessed',
                  style: primaryTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Segera Selesaikan',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Pesanan Anda',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.pending_actions_rounded,
              size: 50,
              color: secondaryColor,
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              helloSeller(),
              FutureBuilder(
                future: getOrdersData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return cardPesananMasuk(totalOrders, potentialPrice);
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
              FutureBuilder(
                future: getOrdersData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return cardPesananSelesai(ordersDone);
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
              FutureBuilder(
                future: getOrdersData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return cardPesananDiproses(ordersProcessed);
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
