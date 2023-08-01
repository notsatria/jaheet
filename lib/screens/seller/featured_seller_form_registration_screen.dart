import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/provider/transaction_screen_provider.dart';
import 'package:jahitin/screens/seller/seller_main_screen.dart';
import 'package:provider/provider.dart';

import '../../constant/theme.dart';

class FeaturedSellerFormRegistration extends StatelessWidget {
  const FeaturedSellerFormRegistration({super.key});

  static const routeName = '/featured-seller-form-registration';

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Mendaftar Premium',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: semiBold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, SellerMainScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
          ),
        ),
        elevation: 2,
      );
    }

    Widget registerToFeaturedSeller() {
      return Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection("seller")
                .doc(context.read<TransactionScreenProvider>().sellerId)
                .update({"isFeaturedSeller": true});
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  insetPadding: const EdgeInsets.all(90),
                  content: SizedBox(
                    height: 128,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 60,
                          color: Colors.greenAccent,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Anda terdaftar Premium',
                          textAlign: TextAlign.center,
                          style: primaryTextStyle,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pushReplacementNamed(
                  context, SellerMainScreen.routeName);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.stars_rounded),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Daftar Penjaheet Premium",
                  style: primaryTextStyle.copyWith(
                    color: backgroundColor1,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget body() {
      return Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                  child: Image.asset(
                    'assets/images/background-premium.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                  color: secondaryColor.withOpacity(0.4),
                ),
                child: Text(
                  "Ayo Mendaftar\nPenjaheet Premium!",
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text(
                  "Apa yang akan Anda dapatkan?",
                  style: primaryTextStyle.copyWith(
                    color: secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Masuk dalam kueri pencarian teratas",
                  style: primaryTextStyle.copyWith(
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  '"Memudahkan pengguna mencari, mendapatkan, dan memesan jasa jahit dari tempat Anda"',
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                registerToFeaturedSeller()
              ],
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }
}
