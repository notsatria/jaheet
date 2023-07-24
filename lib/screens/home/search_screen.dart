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
  TextEditingController _searchController = TextEditingController();
  static const List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Jahit',
    ),
    Tab(
      text: 'Kain',
    ),
  ];

  late TabController _tabController;
  late String keyword;
  late List<DocumentSnapshot> _sellerData;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController = TextEditingController();
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
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          keyword = _searchController.text;
                        });
                      },
                      controller: _searchController,
                      style: subtitleTextStyle,
                      autofocus: true,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Search',
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
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

    Widget jahitGridView(String target) {
      return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('seller')
            .where(
              target == "sailor" ? "isSailor" : "isClothSeller",
              isEqualTo: true,
            )
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData) {
            final sellers = snapshot.data!.docs;
            return Container(
              margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1 / 1.56),
                children: [
                  for (final data in sellers)
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, DetailScreen.routeName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [cardShadow],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8)),
                              child: Image.asset(
                                'assets/images/userprofile.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${Haversine.calculateDistance(context.watch<LocationProvider>().lat, context.watch<LocationProvider>().long, data.data()['location'].latitude, data.data()['location'].longitude).toInt()} m',
                                      style: secondaryTextStyle,
                                      softWrap: true,
                                      overflow: TextOverflow.clip,
                                    ),
                                    Text(
                                      data.data()['name'],
                                      style: primaryTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color:
                                              Color.fromARGB(255, 250, 229, 36),
                                        ),
                                        Text(
                                          data.data()['rating'].toString(),
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 14),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            );
          }
          return SizedBox();
        },
      );
    }

    Widget tabBarView() {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 157,
        child: TabBarView(
          controller: _tabController,
          children: [
            jahitGridView("sailor"),
            jahitGridView("clothSeller"),
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
            if (_searchController.text.isEmpty)
              Expanded(
                child: Column(
                  children: [
                    searchOption(),
                    SingleChildScrollView(
                      child: tabBarView(),
                    ),
                  ],
                ),
              ),
            if (_searchController.text.isNotEmpty)
              StreamBuilder<QuerySnapshot>(
                stream: (_searchController.text.isNotEmpty)
                    ? FirebaseFirestore.instance
                        .collection('seller')
                        .where("name",
                            isGreaterThanOrEqualTo: _searchController.text)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection("seller")
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Text('No data found.');
                  }
                  final sellers = snapshot.data!.docs;
                  return Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: sellers.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = sellers[index];
                        return ListTile(
                          title: Text(data["name"]),
                        );
                      },
                    ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
