import 'package:flutter/material.dart';
import '../../constant/theme.dart';

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

    Widget tabBarView() {
      return Container(
        height: 400,
        child: TabBarView(
          controller: _tabController,
          children: [
            // Content for the first tab
            Container(
              child: Center(
                child: Text('Content for Jahit tab'),
              ),
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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  searchOption(),
                  SingleChildScrollView(child: tabBarView())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
