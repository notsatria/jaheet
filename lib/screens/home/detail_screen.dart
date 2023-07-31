import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/provider/checkout_screen_provider.dart';
import 'package:jahitin/provider/detail_screen_provider.dart';
import 'package:jahitin/provider/send_location_provider.dart';
import 'package:jahitin/screens/home/chatroom_screen.dart';
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

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  bool toggle = false;
  bool isExpanded = false;
  late TabController _tabController;

  List<Tab> myTabs = <Tab>[
    Tab(
      // child: Image.asset(
      //   'assets/icon/baju.png',
      //   width: 25,
      //   height: 25,
      // ),
      text: 'Produk',
    ),
    Tab(
      // child: Image.asset(
      //   'assets/icon/celana.png',
      //   width: 25,
      //   height: 25,
      // ),
      text: 'Category',
    ),
    Tab(
      // child: Image.asset(
      //   'assets/icon/trus.png',
      //   width: 25,
      //   height: 25,
      // ),
      text: 'Rating',
    ),
  ];

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    int id = args['id'];

    Future<void> _navigateToCheckout(BuildContext, int id) async {
      // Mengatur alamat penjual yang akan dikirimkan ketika checkout
      Provider.of<CheckoutScreenProvider>(context, listen: false)
          .setDetailAlamatPenjual({
        'sellerId': Provider.of<DetailScreenProvider>(context, listen: false)
            .detailScreenData!['id'],
        'sellerName': Provider.of<DetailScreenProvider>(context, listen: false)
            .detailScreenData!['name'],
        'subdistric': Provider.of<DetailScreenProvider>(context, listen: false)
            .detailScreenData!['kelurahan'],
        'distric': Provider.of<DetailScreenProvider>(context, listen: false)
            .detailScreenData!['kecamatan'],
        'regency': Provider.of<DetailScreenProvider>(context, listen: false)
            .detailScreenData!['kota'],
        'province': Provider.of<DetailScreenProvider>(context, listen: false)
            .detailScreenData!['provinsi'],
      });

      // Mengatur alamat pemesan yang akan dikirimkan ketika checkout
      Provider.of<CheckoutScreenProvider>(context, listen: false)
          .setDetailAlamatPenerima({
        'type': Provider.of<SendLocationProvider>(context, listen: false)
            .mapSelectedSendLocation['type'],
        'receiverName':
            Provider.of<SendLocationProvider>(context, listen: false)
                .mapSelectedSendLocation['receiverName'],
        'phone': Provider.of<SendLocationProvider>(context, listen: false)
            .mapSelectedSendLocation['phone'],
        'city': Provider.of<SendLocationProvider>(context, listen: false)
            .mapSelectedSendLocation['city'],
        'province': Provider.of<SendLocationProvider>(context, listen: false)
            .mapSelectedSendLocation['province'],
        'additionalDetail':
            Provider.of<SendLocationProvider>(context, listen: false)
                .mapSelectedSendLocation['additionalDetail'],
      });

      // Mendapatkan harga produk
      await Provider.of<CheckoutScreenProvider>(context, listen: false)
          .getPrice(
              Provider.of<DetailScreenProvider>(context, listen: false).getId);

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

    Widget featuredServices(
      String layanan,
      int totalOrder,
      String image,
    ) {
      return SizedBox(
        width: 90,
        height: 90,
        child: Column(
          children: [
            Image.asset(
              image,
              width: 50,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              layanan,
              style: primaryTextStyle.copyWith(fontSize: 14, fontWeight: bold),
            ),
            RichText(
              text: TextSpan(
                  text: 'Total order: ',
                  style: primaryTextStyle.copyWith(fontSize: 11),
                  children: [
                    TextSpan(
                        text: totalOrder.toString(), style: secondaryTextStyle)
                  ]),
            ),
          ],
        ),
      );
    }

    Widget categoryPenjahit() {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            featuredServices(
              'ATASAN',
              120,
              'assets/icon/shirt.png',
            ),
            featuredServices(
              'BAWAHAN',
              67,
              'assets/icon/jeans.png',
            ),
            featuredServices(
              'TERUSAN',
              12,
              'assets/icon/dress.png',
            ),
            featuredServices(
              'PERBAIKAN',
              6,
              'assets/icon/sewing.png',
            ),
          ],
        ),
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

    Widget bottomNavbar(String receiverUserName, int receiverUserID,
        String receiverProfileImage) {
      return Container(
        margin: EdgeInsets.all(defaultMargin - 5),
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChatRoomScreen(
                      receiverUserName: receiverUserName,
                      receiverUserID: receiverUserID.toString(),
                      receiverProfileImage: receiverProfileImage);
                }));
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

    Widget penjahitScreen() {
      return Column(
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
              final deskripsi = detaildata?['description'];

              return titlePenjahit(sellerName, lat, long, kota, provinsi);
            },
          ),
          const Divider(thickness: 4),
          customContainer(
            judul: "Deskripsi",
            child: expandableDescription(
              initialDescription:
                  "Jahit Mas Damar adalah toko jahit yang menghadirkan layanan kreatif dan profesional dalam dunia fashion.",
              expandedDescription:
                  "Dengan penuh dedikasi dan keahlian, toko ini menyediakan jasa jahit dan desain pakaian untuk pelanggan yang mengutamakan kualitas dan ketepatan waktu. Dengan berbagai pilihan kain berkualitas tinggi dan beragam gaya desain, Jahit Mas Damar mampu memenuhi kebutuhan dan keinginan pelanggan dari berbagai lapisan usia dan gaya fashion.",
            ),
          ),
          const Divider(thickness: 4),
          customContainer(
            judul: "Gallery Penjahit",
            child: galleryPenjahit(),
          ),
          const Divider(thickness: 4),
          customContainer(
            judul: "Layanan Unggulan",
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
      );
    }

    Widget titleMarket(name, kota, provinsi) {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  'Kota $kota, $provinsi',
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '4.5',
                          style: primaryTextStyle.copyWith(
                            fontWeight: bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '  Rating & Ulasan',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
                Container(
                  width: 1.5,
                  height: 40,
                  color: Colors.grey.shade300,
                ),
                Column(
                  children: [
                    Text(
                      '5 Jam',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '  Pesanan diproses',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
                Container(
                  width: 1.5,
                  height: 40,
                  color: Colors.grey.shade300,
                ),
                Column(
                  children: [
                    Text(
                      '24 Jam',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '  Jam operasi toko',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget allProducts() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
          vertical: 8,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Semua produk',
                style: primaryTextStyle.copyWith(fontWeight: bold),
              ),
            ),
          ],
        ),
      );
    }

    Widget gridView() {
      return Container(
        margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
        child: GridView(
          padding: const EdgeInsets.only(bottom: 16, left: 5, right: 5),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          children: [
            for (int i = 1; i <= 10; i++)
              Container(
                decoration: BoxDecoration(
                  boxShadow: [cardShadow],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 175,
                        child: Image.asset(
                          'assets/images/fashion.png',
                          fit: BoxFit.cover,
                          height: 50,
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Container(
                    //     padding: const EdgeInsets.all(12),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           'Item $i', // Display item number
                    //           style: primaryTextStyle.copyWith(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //           overflow: TextOverflow.ellipsis,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
          ],
        ),
      );
    }

    Widget searchOption() {
      return SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
            border: const Border(
              bottom: BorderSide(
                color: Color.fromARGB(177, 158, 158, 158),
                width: 2,
              ),
            ),
          ),
          child: TabBar(
            labelColor: primaryColor,
            labelStyle: primaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            indicatorColor: primaryColor,
            unselectedLabelColor: const Color.fromARGB(177, 158, 158, 158),
            controller: _tabController,
            indicatorPadding: EdgeInsets.zero,
            tabs: myTabs,
          ),
        ),
      );
    }

    Widget tabBarView() {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 157,
        child: TabBarView(
          controller: _tabController,
          children: [
            gridView(),
            gridView(),
            gridView(),
          ],
        ),
      );
    }

    Widget marketScreen() {
      return Column(
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

              final kota = detaildata?['kota'];
              final provinsi = detaildata?['provinsi'];

              return titleMarket(sellerName, kota, provinsi);
            },
          ),
          const Divider(
            thickness: 1.5,
          ),
          searchOption(),
          tabBarView(),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 2,
          child: Consumer<DetailScreenProvider>(
              builder: (context, detailScreenProvider, _) {
            final detaildata = detailScreenProvider.detailScreenData;
            final username = detaildata?['name'];
            final sellerId = detaildata?['id'];
            final profileImage = detaildata?['profileImage'];
            return bottomNavbar(
              username,
              sellerId,
              profileImage,
            );
          }),
        ),
        backgroundColor: backgroundColor1,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Consumer<DetailScreenProvider>(
                  builder: (context, detailScreenProvider, _) {
                final detaildata = detailScreenProvider.detailScreenData;
                print(detaildata);
                final type = detaildata?['isClothSeller'];
                print(type);
                return (type) ? marketScreen() : penjahitScreen();
              }),
            ),
            floatingBackButton(),
          ],
        ),
      ),
    );
  }
}
