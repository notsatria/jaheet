import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/provider/detail_screen_provider.dart';
import 'package:jahitin/screens/transaction/service_screen.dart';
import 'package:provider/provider.dart';

import '../../constant/theme.dart';
import '../../provider/location_provider.dart';
import '../../services/haversine.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail-screen';
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool toggle = false;
  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    int id = args['id'];

    void _navigateToCheckout(BuildContext, int id) async {
      await context.read<DetailScreenProvider>().fetchDetailScreenData(id);
      Navigator.pushNamed(context, ServiceScreen.routeName,
          arguments: {'id': id});
    }

    Widget imageHeader(String profileImage) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          double height = width * 9 / 16; // Mengikuti aspek rasio 16:9

          return SizedBox(
            width: width,
            height: height,
            child: Image.network(
              profileImage,
              fit: BoxFit.cover,
            ),
          );
        },
      );
    }

    Widget titlePenjahit(name, lat, long, kota, provinsi) {
      return Container(
        margin: EdgeInsets.all(defaultMargin - 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${Haversine.calculateDistance(context.watch<LocationProvider>().lat, context.watch<LocationProvider>().long, lat, long).toInt()}m dari lokasi Anda',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                Text(
                  name,
                  style: primaryTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.pin_drop_outlined,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$kota, $provinsi',
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      size: 16,
                      color: subtitleTextColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Home Service',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.check,
                      size: 16,
                      color: subtitleTextColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Drop Off',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    )
                  ],
                )
              ],
            ),
            IconButton(
              icon: !toggle
                  ? const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
              onPressed: () {
                setState(() {
                  // Here we changing the icon.
                  toggle = !toggle;
                });
              },
            ),
          ],
        ),
      );
    }

    Widget expandableDescription({
      required String initialDescription,
      required String expandedDescription,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            isExpanded ? expandedDescription : initialDescription,
            maxLines: !isExpanded ? null : 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: toggleExpanded,
            child: Text(
              isExpanded ? 'Tutup' : 'Baca Selengkapnya',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ],
      );
    }

    Widget floatingBackButton() {
      return Positioned(
        top: 20,
        left: 20,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: backgroundColor1,
          mini: true,
          child: Icon(
            Icons.arrow_back,
            color: secondaryColor,
          ),
        ),
      );
    }

    Widget customContainer({
      required String judul,
      required Widget child,
    }) {
      return Container(
        margin: EdgeInsets.symmetric(
            horizontal: defaultMargin - 5, vertical: defaultMargin - 10),
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

    Widget fotoGallery(bool lastItem, {required String gambar}) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: lastItem
            ? Stack(
                children: [
                  Image.asset(
                    gambar,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    child: Center(
                      child: Text(
                        'Lainnya\n+ 20',
                        textAlign: TextAlign.center,
                        style: whiteTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Image.asset(
                gambar,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
      );
    }

    Widget galleryPenjahit() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          fotoGallery(false, gambar: 'assets/images/produk_jahit.png'),
          fotoGallery(false, gambar: 'assets/images/produk_jahit.png'),
          fotoGallery(false, gambar: 'assets/images/produk_jahit.png'),
          fotoGallery(false, gambar: 'assets/images/produk_jahit.png'),
          fotoGallery(true, gambar: 'assets/images/produk_jahit.png'),
        ],
      );
    }

    Widget category(
        {required String nama,
        required int totalOrder,
        required int totalPengerjaan}) {
      return InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(14),
          ),
          width: double.maxFinite,
          height: 74,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'Order: $totalOrder',
                          style: whiteTextStyle.copyWith(
                            fontWeight: light,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.circle,
                          size: 4,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Pengerjaan: ~$totalPengerjaan hari',
                          style: whiteTextStyle.copyWith(
                            fontWeight: light,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: backgroundColor1,
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget categoryPenjahit() {
      return Column(
        children: [
          category(nama: "ATASAN", totalOrder: 120, totalPengerjaan: 2),
          const SizedBox(height: 12),
          category(nama: "BAWAHAN", totalOrder: 70, totalPengerjaan: 2),
          const SizedBox(height: 12),
          category(nama: "PERBAIKAN", totalOrder: 30, totalPengerjaan: 2),
          const SizedBox(height: 12),
          category(nama: "TERUSAN", totalOrder: 10, totalPengerjaan: 5),
        ],
      );
    }

    Widget rating(rating) {
      return Row(
        children: [
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: Colors.amber,
                size: 45,
              ),
              const SizedBox(width: 10),
              Text(
                rating,
                style: primaryTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 36,
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '97% pembeli merasa puas',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '620 Rating | 20 ulasan',
                      style: subtitleTextStyle.copyWith(
                        fontWeight: light,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: primaryTextColor,
                )
              ],
            ),
          )
        ],
      );
    }

    Widget ulasan(String name, String comment) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 10,
                backgroundColor: Colors.black,
                backgroundImage: AssetImage(
                  'assets/icon/google.png',
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(name, style: primaryTextStyle.copyWith(fontSize: 12)),
              const SizedBox(
                width: 4,
              ),
              Text('2 hari lalu',
                  style: subtitleTextStyle.copyWith(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          const SizedBox(
            child: Row(
              children: [
                Icon(Icons.star_rounded, size: 12, color: Colors.amber),
                Icon(Icons.star_rounded, size: 12, color: Colors.amber),
                Icon(Icons.star_rounded, size: 12, color: Colors.amber),
                Icon(Icons.star_rounded, size: 12, color: Colors.amber),
                Icon(Icons.star_rounded, size: 12, color: Colors.amber),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            comment,
            style: primaryTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Image.asset(
            'assets/images/produk_jahit.png',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ],
      );
    }

    Widget ratingUlasan() {
      return Column(
        children: [
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('seller')
                .where("id", isEqualTo: id)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.hasData) {
                final sellers = snapshot.data!.docs;
                if (sellers.isNotEmpty) {
                  final sellerData = sellers.first.data();
                  final rateSeller = sellerData['rating'].toString();
                  return rating(rateSeller);
                } else {
                  return const CircularProgressIndicator();
                }
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 8),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(
            height: 12,
          ),
          ulasan('Sanstoso', 'Jahitannya rapi, keren'),
          const SizedBox(height: 12),
          ulasan('Bambang', 'Cepat dan rapi, Alhamdulillah. Mantap!'),
        ],
      );
    }

    Widget bottomNavbar() {
      return Container(
        margin: EdgeInsets.all(defaultMargin - 5),
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                //
              },
              child: Container(
                width: 50,
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: secondaryColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.message_outlined,
                    color: secondaryColor,
                    size: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: () {
                  _navigateToCheckout(context, id);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Pesan Jasa',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 2,
          child: bottomNavbar(),
        ),
        backgroundColor: backgroundColor1,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<DetailScreenProvider>(
                      builder: (context, detailScreenProvider, _) {
                    final detaildata = detailScreenProvider.detailScreenData;
                    final profileImage = detaildata?['profileImage'];
                    return imageHeader(profileImage);
                  }),
                  Consumer<DetailScreenProvider>(
                    builder: (context, detailScreenProvider, _) {
                      final detaildata = detailScreenProvider.detailScreenData;
                      final sellerName = detaildata?['name'];
                      final long = detaildata?['location'].longitude;
                      final lat = detaildata?['location'].latitude;
                      final kota = detaildata?['kota'];
                      final provinsi = detaildata?['provinsi'];
                      // final sellerId = detaildata?['id'];

                      return titlePenjahit(
                          sellerName, lat, long, kota, provinsi);
                    },
                  ),
                  const Divider(thickness: 4),
                  customContainer(
                    judul: "Deskripsi",
                    child: expandableDescription(
                      initialDescription:
                          "Untuk mendapatkan lebar total layar (width) dalam Flutter, Anda dapat menggunakan widget MediaQuery. MediaQuery adalah widget yang menyediakan",
                      expandedDescription:
                          "Untuk mendapatkan lebar total layar (width) dalam Flutter, Anda dapat menggunakan widget MediaQuery. MediaQuery adalah widget yang menyediakan informasi tentang media (termasuk lebar dan tinggi layar) kepada widget di dalamnya.",
                    ),
                  ),
                  const Divider(thickness: 4),
                  customContainer(
                    judul: "Gallery Penjahit",
                    child: galleryPenjahit(),
                  ),
                  const Divider(thickness: 4),
                  customContainer(
                    judul: "Jasa Jahit dan Permak",
                    child: categoryPenjahit(),
                  ),
                  const Divider(
                    thickness: 4,
                  ),
                  customContainer(
                    judul: "Rating dan Ulasan",
                    child: ratingUlasan(),
                  )
                ],
              ),
            ),
            floatingBackButton(),
          ],
        ),
      ),
    );
  }
}
