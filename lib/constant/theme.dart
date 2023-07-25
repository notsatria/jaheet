import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 20.0;

Color primaryColor = const Color(0xff1B325F);
Color secondaryColor = const Color(0xffF26C4F);
Color alertColor = const Color(0xffED6363);

// Mostly semua halaman pake background color ini
Color backgroundColor1 = const Color(0xffFFFFFF);
// Dipake di homepage penjahit dan chat (?)
Color backgroundColor2 = const Color(0xffEFF3FA);
// Dipake di bagian pesananku
Color backgroundColor3 = const Color(0xffF2F2F2);
// Dipake untuk warna komponen
Color backgroundColor4 = const Color(0xffEEEEEE);

Color primaryTextColor = const Color(0xff1F1F23);
Color subtitleTextColor = const Color(0xff8E8E8E);

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: primaryTextColor,
);

TextStyle subtitleTextStyle = GoogleFonts.poppins(
  color: subtitleTextColor,
);

TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: secondaryColor,
);

TextStyle navyTextStyle = GoogleFonts.poppins(
  color: primaryColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: backgroundColor1,
);

FontWeight light = FontWeight.w300;
FontWeight reguler = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

// Box Shadow
BoxShadow cardShadow = BoxShadow(
    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
    offset: Offset(0, 4),
    blurRadius: 4);
