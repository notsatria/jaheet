import 'package:flutter/material.dart';
import '../../constant/theme.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search-screen';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget searchBar() {
      return Container(
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
          decoration: InputDecoration.collapsed(
            hintText: 'Search',
            hintStyle: subtitleTextStyle,
          ),
        ),
      );
    }

    Widget serviceOption() {
      return Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    shadowColor: Colors.transparent),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Row(
                    children: [
                      Icon(Icons.fire_truck),
                      SizedBox(width: 6),
                      Text(
                        'Home Service',
                        style: whiteTextStyle.copyWith(
                            fontSize: 13, fontWeight: bold),
                      ),
                    ],
                  ),
                )),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    shadowColor: Colors.transparent),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Row(
                    children: [
                      Icon(Icons.pin_drop),
                      SizedBox(width: 6),
                      Text(
                        'Drop-off ke toko',
                        style: whiteTextStyle.copyWith(
                            fontSize: 13, fontWeight: bold),
                      ),
                    ],
                  ),
                )),
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
                    children: [
                      serviceOption(),
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
