import 'package:flutter/material.dart';

import '../constant/theme.dart';
import 'home/main_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/sign-in-screen';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang',
              style: secondaryTextStyle.copyWith(
                fontSize: 28,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Masukkan informasi anda dengan benar untuk menggunakan aplikasi Jaheet',
              style: subtitleTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor4,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextFormField(
              style: subtitleTextStyle,
              decoration: InputDecoration.collapsed(
                hintText: 'E-mail',
                hintStyle: subtitleTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor4,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextFormField(
              style: subtitleTextStyle,
              obscureText: true,
              decoration: InputDecoration.collapsed(
                hintText: 'Password',
                hintStyle: subtitleTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    Widget rememberMe() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                //
              },
              icon: Icon(
                Icons.check_box_rounded,
                size: 24,
                color: primaryColor,
              ),
            ),
            Text(
              'Ingat saya',
              style: subtitleTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    Widget forgotPassword() {
      return TextButton(
        onPressed: () {},
        child: Text(
          'Lupa Password?',
          style: navyTextStyle.copyWith(
            fontSize: 16,
            color: primaryColor,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget buttonLogin() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, MainScreen.routeName);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Masuk',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }

    Widget textSignUp() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun?',
              style: primaryTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SignUpScreen.routeName);
              },
              child: Text(
                'Daftar',
                style: navyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonLoginGoogle() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        height: 50,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor4,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon/google.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Masuk dengan Google',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor1,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              header(),
              emailInput(),
              passwordInput(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  rememberMe(),
                  forgotPassword(),
                ],
              ),
              buttonLogin(),
              textSignUp(),
              buttonLoginGoogle()
            ],
          ),
        ),
      ),
    );
  }
}
