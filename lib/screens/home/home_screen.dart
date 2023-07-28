import 'package:flutter/material.dart';
import 'package:jahitin/provider/location_provider.dart';
import 'package:jahitin/provider/search_screen_provider.dart';
import 'package:jahitin/provider/send_location_provider.dart';
import 'package:jahitin/screens/home/add_location.dart';
import 'package:jahitin/screens/home/address_screen.dart';
import 'package:jahitin/screens/home/detail_screen.dart';
import 'package:jahitin/screens/home/search_screen.dart';
import 'package:jahitin/services/haversine.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import '../../constant/theme.dart';
import '../../provider/detail_screen_provider.dart';
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
    context.read<SendLocationProvider>().fetchSendLocation();
  }

  @override
  void deactivate() {
    context.read<SendLocationProvider>().fetchSendLocation();
    super.deactivate();
  }

  Future<void> _refreshData() async {
    final homeScreenProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);
    await homeScreenProvider.clearState();
    await homeScreenProvider.fetchCategories();
    await homeScreenProvider.fetchNearestSellers();
    await homeScreenProvider.fetchRecommendedSellers();
  }

  void _navigateToDetailScreen(BuildContext context, int id) async {
    await context.read<DetailScreenProvider>().fetchDetailScreenData(id);
    Navigator.pushNamed(context, DetailScreen.routeName, arguments: {'id': id});
  }

  Widget _buildContent() {
    Widget searchBar() {
      return Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                  Provider.of<SearchScreenProvider>(context, listen: false)
                      .fetchData();
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

    Widget locationCard(
        String type,
        bool isSelected,
        String name,
        String phoneNumber,
        String additionalDetail,
        String city,
        String province) {
      return InkWell(
        onTap: () {
          Map<String, dynamic> selectedLocation = {
            "type": type,
            "isSelected": true,
            "receiverName": name,
            "phone": phoneNumber,
            "additionalDetail": additionalDetail,
            "city": city,
            "province": province,
          };
          context
              .read<SendLocationProvider>()
              .setSelectedLocation(selectedLocation);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 10),
          decoration: isSelected
              ? BoxDecoration(
                  border: Border.all(width: 1.5, color: secondaryColor),
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor.withOpacity(0.1),
                )
              : BoxDecoration(
                  border: Border.all(width: 1.0, color: subtitleTextColor),
                  borderRadius: BorderRadius.circular(10),
                ),
          child: SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          type,
                          style: primaryTextStyle.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (isSelected)
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: primaryTextColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Terpilih",
                          style: primaryTextStyle.copyWith(
                              color: primaryTextColor.withOpacity(0.9),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                  ],
                ),
                Text(
                  name,
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  phoneNumber,
                  style: primaryTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  additionalDetail,
                  style: primaryTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '$city, $province',
                  style: primaryTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget addMoreLocation(String name) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, AddressScreen.routeName);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: subtitleTextColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: backgroundColor1,
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4)
                      ]),
                  child: Icon(
                    Icons.chevron_right,
                    color: secondaryColor,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget sendLocation(String? location) {
      return Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            const Icon(
              Icons.pin_drop_outlined,
              color: Colors.white,
            ),
            location != null
                ? Container(
                    padding: const EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10))),
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Mau kirim produk ke mana?",
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      Material(
                                        type: MaterialType.transparency,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.close),
                                          iconSize: 24,
                                          padding: EdgeInsets.zero,
                                          splashRadius: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Consumer<SendLocationProvider>(
                                    builder: (context, sendLocation, _) {
                                      final sendDataLocations =
                                          sendLocation.sendLocation;
                                      return sendDataLocations.isNotEmpty
                                          ? SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  for (final sendDataLocation
                                                      in sendDataLocations)
                                                    locationCard(
                                                      sendDataLocation["type"],
                                                      sendDataLocation[
                                                          "isSelected"],
                                                      sendDataLocation[
                                                          "receiverName"],
                                                      sendDataLocation["phone"],
                                                      sendDataLocation[
                                                          "additionalDetail"],
                                                      sendDataLocation["city"],
                                                      sendDataLocation[
                                                          "province"],
                                                    ),
                                                  addMoreLocation(
                                                      "Cek Alamat Lainnya")
                                                ],
                                              ),
                                            )
                                          : SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  addMoreLocation(
                                                      "Tambahkan Alamat\nPengiriman")
                                                ],
                                              ),
                                            ); // Widget yang akan ditampilkan jika sendDataLocations kosong
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          location.isNotEmpty
                              ? Text(
                                  'Dikirim ke ',
                                  style: primaryTextStyle.copyWith(
                                      color: Colors.white),
                                )
                              : Text(
                                  'Tambah atau pilih alamat',
                                  style: primaryTextStyle.copyWith(
                                      color: Colors.white),
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
                    ),
                  )
                : TextButton(
                    style: TextButton.styleFrom(),
                    onPressed: () {},
                    child: Text(
                      'Pilih Lokasi Pengiriman',
                      style: primaryTextStyle.copyWith(
                          color: Colors.white, fontWeight: bold),
                    ),
                  )
          ],
        ),
      );
    }

    Widget serviceOption() {
      return Container(
        padding: const EdgeInsets.all(15),
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

    Widget category(String title, String image) {
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
                  child: SizedBox(
                    width: 100,
                    height: 75,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
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
          _navigateToDetailScreen(context, id);
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

    Widget skeletonCategoryLoading() {
      return const SkeletonAvatar(
        style: SkeletonAvatarStyle(
            height: 100,
            width: 100,
            padding: EdgeInsets.only(right: 10, top: 10)),
      );
    }

    Widget skeletonSellerLoading() {
      return const SkeletonAvatar(
        style: SkeletonAvatarStyle(
            height: 140,
            width: 120,
            padding: EdgeInsets.only(right: 10, top: 10)),
      );
    }

    Widget categoryOption() {
      return Container(
        padding: const EdgeInsets.only(left: 15),
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
                if (categories.isEmpty) {
                  return Row(
                    children: [
                      for (int i = 0; i < 3; i++) skeletonCategoryLoading()
                    ],
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final categori in categories)
                        category(categori['title'], categori['imageUrl'])
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    Widget nearest(String title) {
      return Container(
        padding: const EdgeInsets.only(left: 15),
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
            Consumer<HomeScreenProvider>(
              builder: (context, homeScreenProvider, _) {
                final sellers = homeScreenProvider.nearestSeller;
                if (sellers.isEmpty) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < 3; i++) skeletonSellerLoading()
                      ],
                    ),
                  );
                }
                return Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final data in sellers)
                          seller(
                            data['id'],
                            data['name'],
                            data['profileImage'],
                            data['rating'].toString(),
                            data['location'].latitude,
                            data['location'].longitude,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    Widget recommended(String title) {
      return Container(
        padding: const EdgeInsets.only(left: 15),
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
            Consumer<HomeScreenProvider>(
              builder: (context, homeScreenProvider, _) {
                final recommendedSellers = homeScreenProvider.recommendedSeller;
                if (recommendedSellers.isEmpty) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < 3; i++) skeletonSellerLoading()
                      ],
                    ),
                  );
                }
                return Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final data in recommendedSellers)
                          seller(
                            data['id'],
                            data['name'],
                            data['profileImage'],
                            data['rating'].toString(),
                            data['location'].latitude,
                            data['location'].longitude,
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            Column(
              children: [
                searchBar(),
                sendLocation(
                    context.watch<SendLocationProvider>().selectedLocation)
              ],
            ),
            Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor,
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: _buildContent(),
        ),
      ),
    );
  }
}
