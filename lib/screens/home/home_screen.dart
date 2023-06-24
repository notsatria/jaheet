import 'package:flutter/material.dart';
import '../../constant/theme.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget searchBar() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Row(
          children: [Text('BoxPencarian')],
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
                  margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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

    Widget categoryOption() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Kategori Layanan'),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text('Atasan'),
                )
              ],
            ),
          )
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor,
        body: Container(
          child: Column(
            children: [
              searchBar(),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: backgroundColor4,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Column(
                  children: [serviceOption(), categoryOption()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
