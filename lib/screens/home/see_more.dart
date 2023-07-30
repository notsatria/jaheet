import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/theme.dart';
import '../../provider/location_provider.dart';
import '../../provider/search_screen_provider.dart';
import '../../services/haversine.dart';
import 'main_screen.dart';

class SeeMoreScreen extends StatefulWidget {
  const SeeMoreScreen({super.key});

  static const routeName = 'see-more-screen';

  @override
  State<SeeMoreScreen> createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  // AppBar
  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: backgroundColor1,
      title: Text(
        'Lihat',
        style: TextStyle(
          color: primaryTextColor,
          fontWeight: semiBold,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, MainScreen.routeName);
        },
        icon: Icon(
          Icons.arrow_back,
          color: primaryTextColor,
        ),
      ),
      elevation: 2,
    );
  }

  // GridView
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
                    // _navigateToDetailScreen(context, data["id"]);
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
                                      color: Color.fromARGB(255, 250, 229, 36),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Text('Test'),
    );
  }
}
