import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/screens/seller/order/seller_order_screen.dart';

import '../../../constant/theme.dart';

class SellerOrderDetailScreen extends StatefulWidget {
  static const routeName = '/seller-order-detail-screen';
  final Map<String, dynamic> orderData;
  const SellerOrderDetailScreen({super.key, required this.orderData});

  @override
  State<SellerOrderDetailScreen> createState() =>
      _SellerOrderDetailScreenState();
}

const List<String> statusOptions = [
  'Menunggu Konfirmasi',
  'Diproses',
  'Menunggu Pembayaran',
  'Dikirim',
  'Selesai',
];

class _SellerOrderDetailScreenState extends State<SellerOrderDetailScreen> {
  String selectedStatus = statusOptions.first;
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  Future<void> updateOrderStatus() async {
    await orders
        .where('orderid', isEqualTo: widget.orderData['orderid'])
        .get()
        .then((value) {
      for (var element in value.docs) {
        orders.doc(element.id).update({
          'order_status': selectedStatus,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Detail Pesananku',
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

    Widget cardPesanan() {
      return Container(
        margin: const EdgeInsets.only(top: 6),
        child: Card(
          child: Container(
            width: double.infinity,
            height: 130,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image.asset('assets/images/produk_jahit.png',
                    width: 80, height: 80),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Order ID: ${widget.orderData['orderid']}',
                      style: subtitleTextStyle,
                    ),
                    Text(
                      widget.orderData['kategori'],
                      style: primaryTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.orderData['jenis'],
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.orderData['jasa'],
                      style: primaryTextStyle.copyWith(
                        fontWeight: reguler,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Harga: Rp 100.000 - Rp 200.000',
                      style: secondaryTextStyle.copyWith(
                        fontWeight: light,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget deskripsiPesanan() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Deskripsi Pesanan ',
                style: primaryTextStyle.copyWith(
                    fontWeight: semiBold, fontSize: 16),
              ),
              Text(
                '(Scroll untuk selengkapnya)',
                style: secondaryTextStyle.copyWith(
                  fontWeight: light,
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(14),
            width: double.infinity,
            constraints: const BoxConstraints(
              maxHeight: 150,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor3,
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Text(
                  widget.orderData['deskripsi'],
                  style: primaryTextStyle.copyWith(
                    fontWeight: light,
                    fontSize: 14,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget pengirimanPesanan() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Pengiriman',
            style:
                primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Card(
            child: ListTile(
              title: Row(
                children: [
                  Icon(
                    widget.orderData['delivery'] == 'drop'
                        ? Icons.storefront
                        : Icons.local_shipping,
                    color: alertColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.orderData['delivery'] == 'drop'
                        ? 'Pick Off'
                        : 'Home Delivery',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    Widget alamatPemesanan() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Alamat Pemesan',
            style:
                primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Card(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.orderData['alamat_pemesan']['additionalDetail'],
                    style: primaryTextStyle.copyWith(
                      fontWeight: reguler,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: alertColor,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.orderData['alamat_pemesan']['phone'],
                        style: primaryTextStyle.copyWith(
                          fontWeight: reguler,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
              subtitle: Text(
                widget.orderData['alamat_pemesan']['type'],
                style: secondaryTextStyle.copyWith(
                  fontWeight: light,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget statusPemesanan() {
      Color statusColor =
          Colors.grey.shade300; // Default color for "Menunggu Konfirmasi"

      switch (widget.orderData['order_status']) {
        case 'Menunggu Konfirmasi':
          statusColor = Colors.grey.shade300;
          break;
        case 'Diproses':
          statusColor = Colors.amber.shade200;
          break;
        case 'Menunggu Pembayaran':
          statusColor = Colors.orange.shade300;
          break;
        case 'Dikirim':
          statusColor = Colors.blue.shade300;
          break;
        case 'Selesai':
          statusColor = Colors.green.shade200;
          break;
        default:
          statusColor = Colors.grey.shade300;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Status Pemesanan',
            style: primaryTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Card(
            child: ListTile(
              title: ClipRRect(
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.orderData['order_status'],
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget updateStatusPemesanan() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Update Status Pemesanan',
            style: primaryTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: DropdownButton<String>(
              iconEnabledColor: secondaryColor,
              isExpanded: true,
              value: selectedStatus,
              onChanged: (value) {
                // When the user selects a status option, update the selectedStatus variable
                setState(() {
                  selectedStatus = value!;
                });
              },
              items:
                  statusOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      );
    }

    Widget bottomNavbar() {
      return Container(
        margin: EdgeInsets.all(defaultMargin - 5),
        width: double.maxFinite,
        height: 45,
        child: InkWell(
          onTap: () {
            // Update the status of the order
            try {
              updateOrderStatus();
            } catch (e) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: Text(e.toString()),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  });
            } finally {
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
                            'Status Pesanan Telah Diperbarui',
                            style: primaryTextStyle,
                            textAlign: TextAlign.center,
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
                  SellerOrderScreen.routeName,
                );
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Update Status',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          child: bottomNavbar(),
        ),
        appBar: appBar(),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                cardPesanan(),
                deskripsiPesanan(),
                pengirimanPesanan(),
                alamatPemesanan(),
                statusPemesanan(),
                updateStatusPemesanan(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
