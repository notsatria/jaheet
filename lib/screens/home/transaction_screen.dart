import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jahitin/screens/home/transaction_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../constant/theme.dart';
import '../../provider/transaction_screen_provider.dart';
import 'main_screen.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});
  static const routeName = 'transaction-screen';

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TransactionScreenProvider transactionProvider = TransactionScreenProvider();

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
    String formattedDate = DateFormat('MMMM dd, yyyy, h:mm a').format(dateTime);
    return formattedDate;
  }

  void navigateToDetail(BuildContext context, String orderid) {
    context.read<TransactionScreenProvider>().fetchDetailScreenData(orderid);
    Navigator.pushNamed(context, TransactionDetailScreen.routeName,
        arguments: {'orderid': orderid});
  }

  List<Map<String, dynamic>> _orders = [];
  Future<void> getAllOrders() async {
    List<Map<String, dynamic>> ordersData =
        await transactionProvider.getOrdersData();
    setState(() {
      _orders = ordersData;
    });
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Transaksi',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: semiBold,
          ),
        ),
        elevation: 2,
      );
    }

    Widget orderItem(
      String sellerName,
      String kategori,
      String jenis,
      String status,
      String jasa,
      String tanggal,
      String orderid,
    ) {
      return GestureDetector(
        onTap: () {
          navigateToDetail(context, orderid);
        },
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          padding: const EdgeInsets.all(12),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 0.5,
              color: Colors.grey.shade500,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    sellerName,
                    style: primaryTextStyle.copyWith(fontWeight: bold),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: waitProcess,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        status,
                        style: primaryTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Divider(
                thickness: 1,
                height: 20,
              ),
              Text(
                '$kategori ($jenis)',
                style: primaryTextStyle.copyWith(fontWeight: semiBold),
              ),
              const SizedBox(height: 4),
              Text(
                jasa,
                style: subtitleTextStyle.copyWith(fontSize: 12),
              ),
              const Divider(
                thickness: 1,
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tanggal,
                    style: subtitleTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    orderid,
                    style: subtitleTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
          appBar: appBar(),
          body: FutureBuilder(
            future: transactionProvider.getOrdersData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data'),
                );
              } else {
                List<Map<String, dynamic>> orders = _orders;

                if (orders.isEmpty) {
                  return const Center(
                    child: Text('Anda belum memesan apapun'),
                  );
                }

                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(defaultMargin),
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> orderData = orders[index];
                        String kategori = orderData['kategori'];
                        String jenis = orderData['jenis'];
                        String jasa = orderData['jasa'];
                        String status = orderData['order_status'];
                        String orderDate = orderData['order-date'];
                        DateTime date = parseOrderDateString(orderDate);
                        String formattedDate = formatDateTime(date);
                        String orderId = orderData['orderid'];
                        var sellerName =
                            orderData['alamat_penjual']['sellerName'];
                        return orderItem(
                          sellerName,
                          kategori,
                          jenis,
                          status,
                          jasa,
                          formattedDate,
                          orderId,
                        );
                      },
                    ),
                  ),
                );
              }
            },
          )),
    );
  }
}
