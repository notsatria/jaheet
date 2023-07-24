import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/provider/location_provider.dart';
import 'package:jahitin/screens/home/detail_screen.dart';
import 'package:jahitin/screens/home/search_screen.dart';
import 'package:jahitin/services/haversine.dart';
import 'package:provider/provider.dart';
import '../../constant/theme.dart';
import '../../provider/home_screen_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final homeScreenProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);
    homeScreenProvider.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    Widget searchBar() {
      return Container(
        margin: const EdgeInsets.all(
          15,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        height: 45,
        decoration: BoxDecoration(
          color: backgroundColor4,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: subtitleTextColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
                child: TextFormField(
                  enabled: false,
                  style: subtitleTextStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Search',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget sendLocation(location) {
      return Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Row(
          children: [
            const Icon(
              Icons.pin_drop_outlined,
              color: Colors.white,
            ),
            location != null
                ? InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          'Dikirim ke ',
                          style: primaryTextStyle.copyWith(color: Colors.white),
                        ),
                        Text(
                          location,
                          style: primaryTextStyle.copyWith(
                              color: Colors.white, fontWeight: bold),
                        ),
                        const Icon(Icons.arrow_drop_down_rounded,
                            color: Colors.white)
                      ],
                    ),
                  )
                : const Text('Pilih Lokasi Pengiriman'),
          ],
        ),
      );
    }

    Widget serviceOption() {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 1,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadowColor: Colors.transparent),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.home_filled),
                        const SizedBox(width: 6),
                        Text(
                          'Home Service',
                          style: whiteTextStyle.copyWith(
                              fontSize: 14, fontWeight: bold),
                        ),
                      ],
                    ),
                  )),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadowColor: Colors.transparent),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.pin_drop),
                        const SizedBox(width: 6),
                        Text(
                          'Drop-off ke toko',
                          style: whiteTextStyle.copyWith(
                              fontSize: 14, fontWeight: bold),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      );
    }

    Widget divider() {
      return const Divider(
        thickness: 4,
      );
    }

    Widget category(title) {
      return Container(
        margin: const EdgeInsets.only(right: 12, bottom: 10, top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryTextColor)),
        child: Row(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.asset(
                    'assets/images/userprofile.jpg',
                    width: 100,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    title,
                    style: primaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget seller(id, name, imageUrl, rating, lat, long) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, DetailScreen.routeName,
              arguments: {'id': id});
        },
        child: Container(
          margin: const EdgeInsets.only(left: 5, right: 12, bottom: 10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4)
          ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${Haversine.calculateDistance(context.watch<LocationProvider>().lat, context.watch<LocationProvider>().long, lat, long).toInt()} m',
                          style: secondaryTextStyle,
                          softWrap: true,
                        ),
                        Text(
                          name,
                          style: primaryTextStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 250, 229, 36),
                            ),
                            Text(
                              rating,
                              style: primaryTextStyle.copyWith(fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget categoryOption() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori Layanan',
              style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            Consumer<HomeScreenProvider>(
              builder: (context, homeScreenProvider, _) {
                final categories = homeScreenProvider.category;
                return Row(
                  children: [
                    for (final categori in categories)
                      category(categori['title'])
                  ],
                );
              },
            ),
          ],
        ),
      );
    }

    Widget nearest(String title) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:
                      primaryTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Lihat Semua',
                      style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                          color: secondaryColor),
                    ))
              ],
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance.collection('seller').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  final sellers = snapshot.data!.docs;

                  // Menghitung jarak untuk setiap penjual menggunakan Haversine
                  final currentLatitude = context.read<LocationProvider>().lat;
                  final currentLongitude =
                      context.read<LocationProvider>().long;
                  sellers.sort((a, b) {
                    final distanceA = Haversine.calculateDistance(
                      currentLatitude,
                      currentLongitude,
                      a.data()['location'].latitude,
                      a.data()['location'].longitude,
                    );
                    final distanceB = Haversine.calculateDistance(
                      currentLatitude,
                      currentLongitude,
                      b.data()['location'].latitude,
                      b.data()['location'].longitude,
                    );
                    return distanceA.compareTo(distanceB);
                  });

                  return Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final data in sellers)
                            seller(
                              data.data()['id'],
                              data.data()['name'],
                              data.data()['profileImage'],
                              data.data()['rating'].toString(),
                              data.data()['location'].latitude,
                              data.data()['location'].longitude,
                            )
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      );
    }

    Widget recommended(String title) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:
                      primaryTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Lihat Semua',
                      style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                          color: secondaryColor),
                    ))
              ],
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('seller')
                  .orderBy('rating', descending: true)
                  .limit(5)
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

                  return Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final data in sellers)
                            seller(
                              data.data()['id'],
                              data.data()['name'],
                              data.data()['profileImage'],
                              data.data()['rating'].toString(),
                              data.data()['location'].latitude,
                              data.data()['location'].longitude,
                            )
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                Column(
                  children: [searchBar(), sendLocation('Kos Bu Wiwik')],
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: backgroundColor4,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      serviceOption(),
                      categoryOption(),
                      divider(),
                      nearest("Paling populer di dekat Anda"),
                      divider(),
                      recommended("Rekomendasi toko lain")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
