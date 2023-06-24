import 'package:flutter/material.dart';
import '../../constant/theme.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

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

    Widget divider() {
      return Divider(
        thickness: 4,
      );
    }

    Widget dummyCategory() {
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
                    'Atasan',
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

    Widget dummySeller() {
      return Container(
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
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
                        '500m',
                        style: secondaryTextStyle,
                        softWrap: true,
                      ),
                      Text(
                        'Rusdi Tailor',
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
                            '4.0',
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
                  dummyCategory(),
                  dummyCategory(),
                  dummyCategory(),
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
            Container(
              margin: EdgeInsets.only(top: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [dummySeller(), dummySeller(), dummySeller()],
                ),
              ),
            )
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
                      categoryOption(),
                      divider(),
                      nearest("Paling populer di dekat Anda"),
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
