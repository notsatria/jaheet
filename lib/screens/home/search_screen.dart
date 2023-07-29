import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jahitin/provider/search_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import '../../constant/theme.dart';
import '../../provider/detail_screen_provider.dart';
import '../../provider/location_provider.dart';
import '../../services/haversine.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

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
      text: 'Market',
    ),
  ];

  late TabController _tabController;
  late String keyword;
  late List<DocumentSnapshot> _sellerData;
  late List<DocumentSnapshot> _searchResults = [];

  void _navigateToDetailScreen(BuildContext context, int id) async {
    await context.read<DetailScreenProvider>().fetchDetailScreenData(id);
    Navigator.pushNamed(context, DetailScreen.routeName, arguments: {'id': id});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
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
              fontSize: 18,
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

    Widget jahitGridView(String target) {
      return Consumer<SearchScreenProvider>(
        builder: (context, searchScreenProvider, _) {
          List<Map<String, dynamic>> sellers = [];
          if (target == "sailor") {
            sellers = searchScreenProvider.sailorSearchResult;
          } else {
            sellers = searchScreenProvider.clothSellerSearchResult;
          }
          return Container(
            margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
            child: GridView(
              padding: const EdgeInsets.only(bottom: 16, left: 5, right: 5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 12,
                childAspectRatio: 1 / 1.56,
              ),
              children: [
                for (final data in sellers)
                  GestureDetector(
                    onTap: () {
                      _navigateToDetailScreen(context, data["id"]);
                    },
                    child: Container(
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
                              child: Image.network(data["profileImage"],
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${Haversine.calculateDistance(
                                      context.watch<LocationProvider>().lat,
                                      context.watch<LocationProvider>().long,
                                      data['location'].latitude,
                                      data['location'].longitude,
                                    ).toInt()} m',
                                    style: secondaryTextStyle,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                    data['name'],
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                        data['rating'].toString(),
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
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

    Widget filterBar() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade500,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                    child: Icon(
                  Icons.tune,
                  size: 18,
                )),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Paling dekat'),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Home Service'),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Drop off'),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Drop off'),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Drop off'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget searchResultsListView() {
      return Expanded(
        child: ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            DocumentSnapshot data = _searchResults[index];
            return GestureDetector(
              onTap: () {
                _navigateToDetailScreen(context, data["id"]);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 4)
                ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 75,
                        height: 75,
                        child: Image.network(
                          data["profileImage"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${Haversine.calculateDistance(context.watch<LocationProvider>().lat, context.watch<LocationProvider>().long, data["location"].latitude, data["location"].longitude).toInt()} m',
                            style: secondaryTextStyle,
                            softWrap: true,
                          ),
                          Text(
                            data["name"],
                            style: primaryTextStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 250, 229, 36),
                              ),
                              Text(
                                data["rating"].toString(),
                                style: primaryTextStyle.copyWith(fontSize: 14),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    Widget skeletonListTile() {
      return SkeletonListTile(
        leadingStyle: SkeletonAvatarStyle(width: 80, height: 80),
        titleStyle: SkeletonLineStyle(height: 20),
        hasSubtitle: true,
        subtitleStyle: SkeletonLineStyle(randomLength: true),
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
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    // filterBar(),
                    Flexible(
                      child: SingleChildScrollView(
                        child: tabBarView(),
                      ),
                    ),
                  ],
                ),
              ),
            if (_searchController.text.isNotEmpty)
              FutureBuilder(
                future: FirebaseFirestore.instance.collection('seller').get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          for (int i = 0; i < 4; i++) skeletonListTile()
                        ],
                      ),
                    );
                  }
                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data == []) {
                    return Center(child: Text('No data found.'));
                  }

                  // Store all sellers in _sellerData list
                  _sellerData = snapshot.data!.docs;

                  // Perform the local search based on the "name" field
                  _searchResults = _sellerData.where((seller) {
                    String name = seller["name"].toString().toLowerCase();
                    String searchQuery = _searchController.text.toLowerCase();
                    return name.contains(searchQuery);
                  }).toList();

                  // Show the search results in a ListView
                  return searchResultsListView();
                },
              ),
          ],
        ),
      ),
    );
  }
}
