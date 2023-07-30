import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jahitin/provider/send_location_provider.dart';
import 'package:jahitin/screens/home/transaction_screen.dart';
import 'package:jahitin/screens/transaction/delivery_screen.dart';
import 'package:provider/provider.dart';
import '../../constant/theme.dart';
import '../../provider/checkout_screen_provider.dart';
import '../../provider/detail_screen_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  static const routeName = '/checkout-screen';

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
    final checkoutProvider = Provider.of<CheckoutScreenProvider>(
      context,
      listen: false,
    );

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

    Widget homeDetail(
      String mode,
      String type,
      String receiverName,
      String phoneNumber,
      String city,
      String province,
      String? additionalDetail,
    ) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(width: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mode,
                    style: primaryTextStyle.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      text: type,
                      style: secondaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 12,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' - $receiverName ($phoneNumber)',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: reguler,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '$city, $province',
                    style: subtitleTextStyle.copyWith(fontSize: 12),
                  ),
                  Text(
                    additionalDetail ?? '',
                    style: subtitleTextStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget deliveyContainer() {
      String delivery = checkoutProvider.getDelivery;
      String deliveryText = '';
      switch (delivery) {
        case 'drop':
          deliveryText = 'Pick Off';
          break;
        case 'home':
          deliveryText = 'Home Delivery';
          break;
        default:
          deliveryText = '';
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  size: 20,
                  color: secondaryColor,
                ),
                const SizedBox(width: 10),
                RichText(
                  text: TextSpan(
                      text: 'Metode pengiriman',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red.shade700,
                          ),
                        ),
                      ]),
                ),
                const Spacer(),
                Text(
                  deliveryText,
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: secondaryColor,
                ),
              ],
            ),
            delivery == 'home'
                ? homeDetail(
                    "Dikirim ke",
                    context
                        .watch<SendLocationProvider>()
                        .mapSelectedSendLocation['type'],
                    context
                        .watch<SendLocationProvider>()
                        .mapSelectedSendLocation['receiverName'],
                    context
                        .watch<SendLocationProvider>()
                        .mapSelectedSendLocation['phone'],
                    context
                        .watch<SendLocationProvider>()
                        .mapSelectedSendLocation['city'],
                    context
                        .watch<SendLocationProvider>()
                        .mapSelectedSendLocation['province'],
                    context
                        .watch<SendLocationProvider>()
                        .mapSelectedSendLocation['additionalDetail'])
                : homeDetail(
                    "Diambil di",
                    'Toko',
                    context
                        .watch<DetailScreenProvider>()
                        .detailScreenData!['name'],
                    context
                        .watch<DetailScreenProvider>()
                        .detailScreenData!['kelurahan'],
                    context
                        .watch<DetailScreenProvider>()
                        .detailScreenData!['kota'],
                    context
                        .watch<DetailScreenProvider>()
                        .detailScreenData!['provinsi'],
                    null),
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

    Widget detailJasa({
      required String urlfoto,
      required String kategori,
      required String jenis,
      required String jasa,
      required String size,
    }) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: subtitleTextColor,
            width: 0.5,
          ),
        ),
        height: 80,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Image.asset(
                  urlfoto,
                  height: 50,
                  width: 50,
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
                  '$kategori ($jenis)',
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  jasa,
                  style: subtitleTextStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Size: $size',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 11,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget detailPesanan(String sellerName) {
      String date = checkoutProvider.getOrderDate;
      int sellerId = checkoutProvider.getSellerId;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sellerName,
            style: primaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 8),
          detailJasa(
            urlfoto: 'assets/images/produk_jahit_2.png',
            kategori: checkoutProvider.getKategori,
            jenis: checkoutProvider.getJenis,
            jasa: checkoutProvider.getJasa,
            size: checkoutProvider.getSize,
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '$sellerId-$date',
              style: subtitleTextStyle.copyWith(fontSize: 8),
            ),
          )
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
                onChanged: (value) {
                  checkoutProvider.setDeskripsi(value);
                },
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: subtitleTextStyle.copyWith(fontSize: 14),
                  hintText: 'Contoh: lingkar perut saya 45cm',
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

    Widget bottomNavbar() {
      return Container(
        margin: EdgeInsets.all(defaultMargin - 5),
        width: double.maxFinite,
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${context.watch<CheckoutScreenProvider>().getHargaMinimal} - ${context.watch<CheckoutScreenProvider>().getHargaMaksimal}',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            InkWell(
              onTap: () {
                try {
                  checkoutProvider.sendCheckoutData();
                } catch (e) {
                  throw Exception(e);
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
                                'Pesanan telah dibuat',
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
                      TransactionScreen.routeName,
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
                  'Checkout',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                )),
              ),
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: bottomNavbar(),
        ),
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              customContainer(
                judul: 'Pemesanan dari Toko',
                child: Consumer<DetailScreenProvider>(
                    builder: (context, detailScreenProvider, _) {
                  final detaildata = detailScreenProvider.detailScreenData;
                  final sellerName = detaildata?['name'];
                  return detailPesanan(sellerName);
                }),
              ),
              const SizedBox(height: 12),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 12),
              customContainer(
                judul: 'Deskripsi Pesanan (optional)',
                child: deskripsiPesanan(),
              ),
              const SizedBox(height: 12),
              const Divider(
                thickness: 2,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, DeliveryScreen.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: deliveyContainer(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
