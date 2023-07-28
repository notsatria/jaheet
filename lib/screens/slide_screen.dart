import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

import '../constant/theme.dart';
import 'sign_in_screen.dart';

class SlideScreen extends StatefulWidget {
  static const routeName = '/slide-screen';
  const SlideScreen({super.key});

  @override
  State<SlideScreen> createState() => _SlideScreenState();
}

class _SlideScreenState extends State<SlideScreen> {
  List<ContentConfig> listSliderContent = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listSliderContent.add(
      ContentConfig(
        description:
            'Jaheet merupakan aplikasi E-Commerce platform mobile untuk menunjang digitalisasi pada dunia fashion',
        pathImage: 'assets/images/olshop.gif',
        widthImage: 300,
        backgroundColor: Colors.white,
        styleDescription: primaryTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
        ),
      ),
    );
    listSliderContent.add(
      ContentConfig(
        description:
            'Jaheet memudahkan anda untuk mencari jasa jahit yang sesuai dengan kebutuhan anda tanpa harus keluar rumah',
        pathImage: 'assets/images/relax.gif',
        widthImage: 300,
        backgroundColor: Colors.white,
        styleDescription: primaryTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
        ),
      ),
    );
    listSliderContent.add(
      ContentConfig(
        description:
            'Jaheet memudahkan penjahit untuk memasarkan jasa jahitnya secara online dan memperluas jangkauan pasar',
        pathImage: 'assets/images/jahit.gif',
        widthImage: 300,
        backgroundColor: Colors.white,
        styleDescription: primaryTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
        ),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacementNamed(context, SignInScreen.routeName);
  }

  void onSkipPRess() {
    Navigator.pushReplacementNamed(context, SignInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listSliderContent,
      onDonePress: onDonePress,
      onSkipPress: onSkipPRess,
      nextButtonStyle: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
      skipButtonStyle: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
      doneButtonStyle: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    );
  }
}
