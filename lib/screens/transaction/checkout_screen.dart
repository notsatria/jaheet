import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jahitin/screens/transaction/delivery_screen.dart';
import 'package:jahitin/screens/transaction/service_screen.dart';
import '../../constant/theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.data});
  static const routeName = '/checkout-screen';
  final Map<String, String> data;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

final ImagePicker _imagePicker = ImagePicker();
List<XFile>? _pickedImage = [];

class _CheckoutScreenState extends State<CheckoutScreen> {
  Future<void> _selectImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage!.add(pickedImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String kategori = widget.data['kategori'] ?? '';
    String jenis = widget.data['jenis'] ?? '';
    String jasa = widget.data['jasa'] ?? '';
    if (kategori == '') {
      kategori = 'ATASAN';
    } else if (jenis == '') {
      jenis = 'Batik';
    } else if (jasa == '') {
      jasa = 'Jahit termasuk bahan';
    }

    bool isHomeService = false;
    void pickService() {
      setState(() {
        isHomeService = !isHomeService;
      });
    }

    Widget customContainer({
      required String judul,
      required Widget child,
    }) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul,
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Container(child: child),
          ],
        ),
      );
    }

    Widget deliveyContainer() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.local_shipping_outlined,
              size: 20,
              color: secondaryColor,
            ),
            const SizedBox(width: 10),
            Text(
              'Pengiriman',
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: secondaryColor,
            ),
          ],
        ),
      );
    }

    Widget paymentContainer() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.credit_card,
              size: 20,
              color: secondaryColor,
            ),
            const SizedBox(width: 10),
            Text(
              'Pembayaran',
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: secondaryColor,
            ),
          ],
        ),
      );
    }

    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Checkout',
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

    Widget imagePicker() {
      return Row(
        children: [
          InkWell(
            onTap: _selectImage,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: const Icon(Icons.image),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _pickedImage?.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 70,
                  height: 70,
                  margin: const EdgeInsets.only(right: 10),
                  child: Image.file(
                    File(_pickedImage![index].path),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    Widget detailJasa(
        {required String urlfoto,
        required String kategori,
        required String item,
        required String jasa}) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: subtitleTextColor,
            width: 0.5,
          ),
        ),
        height: 60,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Image.asset(
                  urlfoto,
                  height: 45,
                  width: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$kategori ($item)',
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  jasa,
                  style: subtitleTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            //nanti ditambahkan counter widget disini, tp belom ada hehe
            Text(
              'x 1',
              style:
                  subtitleTextStyle.copyWith(fontSize: 12, fontWeight: light),
            ),
            const SizedBox(width: 4),
          ],
        ),
      );
    }

    Widget detailPesanan(String namaToko) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            namaToko,
            style: primaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 8),
          detailJasa(
            urlfoto: 'assets/images/produk_jahit_2.png',
            kategori: kategori,
            item: jenis,
            jasa: jasa,
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ServiceScreen.routeName);
            },
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: subtitleTextColor,
                  width: 0.5,
                ),
              ),
              child: Center(
                child: Text(
                  'Tambah Jasa',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget deskripsiPesanan() {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: subtitleTextStyle.copyWith(fontSize: 14),
                  hintText: 'Tuliskan deskripsi singkat pesanan anda...',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              imagePicker(),
            ],
          )
        ],
      );
    }

    //untuk membuat card yang bisa di klik, yang ada tanda panah
    Widget buttonCard(
      Color background, {
      required Widget child,
      required String url,
    }) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: background,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            child,
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: primaryTextColor,
            ),
          ],
        ),
      );
    }

    Widget pengiriman() {
      return Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: secondaryColor,
                  ),
                  child: Center(
                      child: Text(
                    'Home service',
                    style: whiteTextStyle.copyWith(
                      fontSize: 11,
                      fontWeight: bold,
                    ),
                  )),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  pickService();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: secondaryColor,
                  ),
                  child: Center(
                      child: Text(
                    'Drop off',
                    style: whiteTextStyle.copyWith(
                      fontSize: 11,
                      fontWeight: bold,
                    ),
                  )),
                ),
              ),
            ],
          )
        ],
      );
    }

    Widget homeService() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dikirim ke',
                style: primaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: bold,
                ),
              ),
              Text(
                'Rumah',
                style: primaryTextStyle.copyWith(
                  color: secondaryColor,
                  fontSize: 12,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              customContainer(
                judul: 'Pemesanan dari Toko',
                child: detailPesanan('Jasa Jahit Bu Rusmiati'),
              ),
              const SizedBox(height: 12),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 12),
              customContainer(
                judul: 'Deskripsikan Pesanan (optional)',
                child: deskripsiPesanan(),
              ),
              const SizedBox(height: 12),
              const Divider(
                thickness: 2,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, DeliveryScreen.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: deliveyContainer(),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, DeliveryScreen.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: paymentContainer(),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
