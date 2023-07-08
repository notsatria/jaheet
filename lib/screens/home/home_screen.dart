import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/screens/home/detail_screen.dart';
import 'package:jahitin/screens/home/search_screen.dart';
import 'package:jahitin/services/haversine.dart';
import '../../constant/theme.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

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

    Widget serviceOption() {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
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
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.fire_truck),
                        SizedBox(width: 6),
                        Text(
                          'Home Service',
                          style: whiteTextStyle.copyWith(
                              fontSize: 14, fontWeight: bold),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(width: 10),
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
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.pin_drop),
                        SizedBox(width: 6),
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
      return Divider(
        thickness: 4,
      );
    }

    Widget category(title) {
      return Container(
        margin: EdgeInsets.only(right: 12, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryTextColor)),
        child: Row(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.asset(
                    'assets/images/userprofile.jpg',
                    width: 100,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
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

    Widget seller(name, rating, lat, long) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, DetailScreen.routeName);
        },
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 12, bottom: 10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                offset: Offset(0, 4),
                blurRadius: 4)
          ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8)),
                    child: Image.asset(
                      'assets/images/userprofile.jpg',
                      width: 120,
                    ),
                  ),
                  Container(
                    width: 120,
                    decoration: BoxDecoration(),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${Haversine.calculateDistance(-7.058376, 110.430547, lat, long).toInt()} m',
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
                            Icon(
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
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori Layanan',
              style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  // FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  //   future: FirebaseFirestore.instance
                  //       .collection('categories')
                  //       .get(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return CircularProgressIndicator();
                  //     }
                  //     if (snapshot.hasError) {
                  //       return Text('Error: ${snapshot.error}');
                  //     }
                  //     if (snapshot.hasData) {
                  //       final users = snapshot.data!.docs;
                  //       return Container(
                  //         margin: EdgeInsets.only(top: 12),
                  //         child: Row(
                  //           children: [
                  //             for (final user in users)
                  //               category(user.data()['title'])
                  //           ],
                  //         ),
                  //       );
                  //     }
                  //     return SizedBox();
                  //   },
                  // ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget nearest(String title) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: primaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: bold),
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
            margin: EdgeInsets.only(top: 12),
            child: Column(
              children: [
                searchBar(),
                Container(
                  padding: EdgeInsets.all(15),
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
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('categories')
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.hasData) {
                            final users = snapshot.data!.docs;
                            return Container(
                              child: Row(
                                children: [
                                  for (final user in users)
                                    category(user.data()['title'])
                                ],
                              ),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                      divider(),
                      nearest("Paling populer di dekat Anda"),
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('seller')
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.hasData) {
                            final sellers = snapshot.data!.docs;

                            // Menghitung jarak untuk setiap penjual menggunakan Haversine
                            final currentLatitude = -7.058376;
                            final currentLongitude = 110.430547;
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
                              margin: EdgeInsets.only(top: 12),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (final data in sellers)
                                      seller(
                                          data.data()['name'],
                                          data.data()['rating'].toString(),
                                          data.data()['location'].latitude,
                                          data.data()['location'].longitude)
                                  ],
                                ),
                              ),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                      divider(),
                      nearest("Rekomendasi toko lain")
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
