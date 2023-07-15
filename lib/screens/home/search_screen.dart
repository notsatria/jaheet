import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/screens/home/detail_screen.dart';
import 'package:provider/provider.dart';
import '../../constant/theme.dart';
import '../../provider/location_provider.dart';
import '../../services/haversine.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Jahit',
    ),
    Tab(
      text: 'Kain',
    ),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget searchBar() {
      return Row(
        children: [
          BackButton(
            color: primaryColor,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              height: 45,
              decoration: BoxDecoration(
                color: backgroundColor4,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                style: subtitleTextStyle,
                autofocus: true,
                decoration: InputDecoration.collapsed(
                  hintText: 'Search',
                  hintStyle: subtitleTextStyle,
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget searchOption() {
      return Container(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(177, 158, 158, 158),
                width: 2,
              ),
            ),
          ),
          child: TabBar(
            labelColor: primaryColor,
            labelStyle: primaryTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
            indicatorColor: primaryColor,
            unselectedLabelColor: Color.fromARGB(177, 158, 158, 158),
            controller: _tabController,
            indicatorPadding: EdgeInsets.zero,
            tabs: myTabs,
          ),
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

    Widget tabBarView() {
      return Container(
        height: MediaQuery.of(context).size.height - 157,
        child: TabBarView(
          controller: _tabController,
          children: [
            // Content for the first tab
            FutureBuilder(
              future: FirebaseFirestore.instance.collection('seller').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  final sellers = snapshot.data!.docs;
                  return ListView(
                    children: [
                      for (final data in sellers)
                        seller(
                            data.data()['name'],
                            data.data()['rating'].toString(),
                            data.data()['location'].latitude,
                            data.data()['location'].longitude)
                    ],
                  );
                }
                return SizedBox();
              },
            ),

            // Content for the second tab
            Container(
              child: Center(
                child: Text('Content for Kain tab'),
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            searchBar(),
            Column(
              children: [
                searchOption(),
                SingleChildScrollView(child: tabBarView())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
