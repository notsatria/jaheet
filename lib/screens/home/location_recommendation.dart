import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jahitin/constant/theme.dart';
import 'package:jahitin/screens/home/detail_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/location_provider.dart';
import '../../services/haversine.dart';

class LocationRecommendationScreen extends StatefulWidget {
  static const routeName = '/location-recommendation-screen';

  const LocationRecommendationScreen({Key? key}) : super(key: key);

  @override
  State<LocationRecommendationScreen> createState() =>
      _LocationRecommendationScreenState();
}

class _LocationRecommendationScreenState
    extends State<LocationRecommendationScreen> {
  late GoogleMapController mapController;
  ScrollController scrollController = ScrollController();

  List<dynamic> locationSet = [];
  int highlightRadius = 1000;
  List<int> radiusOptions = [500, 1000, 2000];

  BitmapDescriptor? customMarkerIcon;

  Future<void> loadCustomMarkerIcon() async {
    final ImageConfiguration config = ImageConfiguration();
    final BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromAssetImage(
            config, 'assets/icon/user-marker.png');
    setState(() {
      customMarkerIcon = bitmapDescriptor;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void getData() {
    FirebaseFirestore.instance
        .collection('seller')
        .get()
        .then((QuerySnapshot snapshot) {
      // Menghapus data lama sebelum menambahkan data baru
      locationSet.clear();

      // Mengurutkan data berdasarkan jarak menggunakan Haversine
      final currentLatitude = context.read<LocationProvider>().lat;
      final currentLongitude = context.read<LocationProvider>().long;

      // Mendapatkan data dari snapshot dan menyimpannya dalam state setLocation
      for (var doc in snapshot.docs) {
        final sellerLatitude = doc['location'].latitude;
        final sellerLongitude = doc['location'].longitude;
        final distance = Haversine.calculateDistance(
          currentLatitude,
          currentLongitude,
          sellerLatitude,
          sellerLongitude,
        );

        if (distance <= highlightRadius) {
          locationSet.add(doc.data());
        }
      }

      locationSet.sort((a, b) {
        final distanceA = Haversine.calculateDistance(
          currentLatitude,
          currentLongitude,
          a['location'].latitude,
          a['location'].longitude,
        );
        final distanceB = Haversine.calculateDistance(
          currentLatitude,
          currentLongitude,
          b['location'].latitude,
          b['location'].longitude,
        );
        return distanceA.compareTo(distanceB);
      });

      // Memperbarui tampilan dengan setState
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData(); // Memanggil getData saat initState dipanggil
    scrollController = ScrollController();
    loadCustomMarkerIcon();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(args['latitude'], args['longitude']),
                  zoom: 15,
                ),
                markers: {
                  ...locationSet.map((data) {
                    final latitude = data['location'].latitude;
                    final longitude = data['location'].longitude;
                    return Marker(
                      markerId: MarkerId('$latitude-$longitude'),
                      position: LatLng(latitude, longitude),
                      icon: BitmapDescriptor.defaultMarker,
                    );
                  }),
                  Marker(
                    markerId: MarkerId('userLocation'),
                    position: LatLng(context.watch<LocationProvider>().lat,
                        context.watch<LocationProvider>().long),
                    icon: customMarkerIcon ?? BitmapDescriptor.defaultMarker,
                  ),
                },
                circles: {
                  Circle(
                    circleId: const CircleId("1"),
                    center: LatLng(context.watch<LocationProvider>().lat,
                        context.watch<LocationProvider>().long),
                    radius: highlightRadius.toDouble(),
                    strokeWidth: 2,
                    strokeColor: const Color.fromRGBO(0, 133, 255, 0.44),
                    fillColor: const Color.fromRGBO(0, 133, 255, 0.17),
                  ),
                },
              ),
              DraggableScrollableSheet(
                snap: true,
                initialChildSize: 0.2,
                minChildSize: 0.2,
                maxChildSize: 0.5,
                builder: (context, scrollController) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, -52),
                              blurRadius: 15,
                              color: Color.fromRGBO(0, 0, 0, 0)),
                          BoxShadow(
                              offset: Offset(0, -33),
                              blurRadius: 13,
                              color: Color.fromRGBO(0, 0, 0, 0.01)),
                          BoxShadow(
                              offset: Offset(0, -19),
                              blurRadius: 11,
                              color: Color.fromRGBO(0, 0, 0, 0.05)),
                          BoxShadow(
                              offset: Offset(0, -8),
                              blurRadius: 8,
                              color: Color.fromRGBO(0, 0, 0, 0.09)),
                          BoxShadow(
                              offset: Offset(0, -2),
                              blurRadius: 5,
                              color: Color.fromRGBO(0, 0, 0, 0.1)),
                          BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 0,
                              color: Color.fromRGBO(0, 0, 0, 0.1))
                        ]),
                    child: Column(
                      children: [
                        // Dropdown untuk memilih highlightRadius
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Menampilkan penjual di radius : ",
                                style: primaryTextStyle.copyWith(fontSize: 14)),
                            DropdownButton<int>(
                              icon: Icon(Icons.arrow_drop_down_rounded,
                                  color: secondaryColor),
                              style: primaryTextStyle.copyWith(
                                  fontSize: 16, color: secondaryColor),
                              value: highlightRadius,
                              items: radiusOptions.map((int radius) {
                                return DropdownMenuItem<int>(
                                  value: radius,
                                  child: Text('${radius} m'),
                                );
                              }).toList(),
                              onChanged: (int? newValue) {
                                // Mengubah tipe data parameter menjadi int?
                                if (newValue != null) {
                                  // Memastikan nilai newValue tidak null
                                  setState(() {
                                    highlightRadius = newValue;
                                  });
                                  getData();
                                }
                              },
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            controller: scrollController,
                            itemCount: locationSet.length,
                            itemBuilder: (context, index) {
                              final locationData = locationSet[index];
                              // Tampilkan data yang sesuai di dalam ListView
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailScreen()));
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                  locationData[
                                                          "profileImage"] ??
                                                      "https://firebasestorage.googleapis.com/v0/b/jaheet-5fa13.appspot.com/o/userprofile.jpg?alt=media",
                                                )),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${Haversine.calculateDistance(context.watch<LocationProvider>().lat, context.watch<LocationProvider>().long, locationData["location"].latitude, locationData["location"].longitude).toInt()} m',
                                                      style: primaryTextStyle
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  secondaryColor),
                                                    ),
                                                    Text(
                                                      locationData["name"],
                                                      style: primaryTextStyle
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Text(
                                                      locationData["address"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: primaryTextStyle
                                                          .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: secondaryColor,
                                              size: 30,
                                            )
                                          ],
                                        ),
                                        Divider(thickness: 1)
                                      ],
                                    )),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: Container(
            margin: EdgeInsets.only(top: 15),
            child: FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.chevron_left),
            ),
          ),
        ),
      ),
    );
  }
}
