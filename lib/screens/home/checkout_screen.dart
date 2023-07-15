import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constant/theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

final ImagePicker _imagePicker = ImagePicker();
XFile? _pickedImage;

Future<void> _selectImage() async {
  final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    _pickedImage = pickedImage;
  }
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;

    Widget customContainer({
      required String judul,
      required Widget child,
    }) {
      return Container(
        margin: EdgeInsets.all(defaultMargin - 14),
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

    Widget detailJasa(
        {required String urlfoto,
        required String kategori,
        required String item,
        required String jasa}) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: subtitleTextColor,
            width: 0.5,
          ),
        ),
        margin: const EdgeInsets.all(4),
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              urlfoto,
              height: 42,
              width: 42,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$kategori($item)',
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  jasa,
                  style: subtitleTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
            //nanti ditambahkan counter widget disini, tp belom ada hehe
            Text(
              'x 1',
              style:
                  subtitleTextStyle.copyWith(fontSize: 12, fontWeight: light),
            )
          ],
        ),
      );
    }

    Widget detailPesanan(String namaToko) {
      return Container(
        margin: EdgeInsets.all(defaultMargin - 14),
        child: Column(
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
              kategori: 'ATASAN',
              item: 'Kemeja Batik',
              jasa: 'Jahit Exclude Bahan',
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
            )
          ],
        ),
      );
    }

    Widget deskripsiPesanan() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: subtitleTextColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const TextField(
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Tuliskan deskripsi singkat pesanan anda...',
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                color: subtitleTextColor,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          )
        ],
      );
    }

    Widget imagePicker() {
      return InkWell(
        onTap: _selectImage,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: _pickedImage != null
              ? Image.file(
                  _pickedImage! as File,
                  fit: BoxFit.cover,
                )
              : Icon(Icons.image),
        ),
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Detail Pemesanan',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              customContainer(
                judul: 'Pemesanan dari Toko',
                child: detailPesanan('Jasa Jahit Bu Rusmiati'),
              ),
              customContainer(
                judul: 'Deskripsikan Pesanan (optional)',
                child: deskripsiPesanan(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
