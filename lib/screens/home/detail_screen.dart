import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../constant/theme.dart';

class DetailScreen extends StatefulWidget {
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
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    Widget imageHeader() {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          double height = width * 9 / 16; // Mengikuti aspek rasio 16:9

          return SizedBox(
            width: width,
            height: height,
            child: Image.asset(
              'assets/images/dummy_tailor_bg.png',
              fit: BoxFit.cover,
            ),
          );
        },
      );
    }

    Widget titlePenjahit() {
      return Container(
        margin: EdgeInsets.all(defaultMargin - 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '200m dari Lokasi Anda',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Jasa Jahit Bu Rusmiati',
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
                      'Semarang Tengah, Kota Semarang',
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    )
                  ],
                )
              ],
            ),
            IconButton(
              icon: toggle
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
            maxLines: isExpanded ? null : 2,
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
          onPressed: () {},
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

    Widget fotoGallery({required String gambar}) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Image.asset(
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
          fotoGallery(gambar: 'assets/images/produk_jahit.png'),
          fotoGallery(gambar: 'assets/images/produk_jahit.png'),
          fotoGallery(gambar: 'assets/images/produk_jahit.png'),
          fotoGallery(gambar: 'assets/images/produk_jahit.png'),
          fotoGallery(gambar: 'assets/images/produk_jahit.png'),
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
            borderRadius: BorderRadius.circular(8),
          ),
          width: fullWidth,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(14),
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
        ],
      );
    }

    Widget rating(String rating) {
      return Column(
        children: [
          const Icon(
            Icons.star_rounded,
            color: Colors.amber,
            size: 40,
          ),
          const SizedBox(width: 10),
          Text(
            rating,
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(width: 14),
          Row(
            children: [
              Column(
                children: [Text('97%')],
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 4,
                  color: primaryTextColor,
                ),
              )
            ],
          )
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor1,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageHeader(),
                  titlePenjahit(),
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
