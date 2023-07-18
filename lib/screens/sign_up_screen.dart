import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/theme.dart';
import '../provider/google_sign_in_provider.dart';
import 'home/main_screen.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up-screen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final auth = FirebaseAuth.instance;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;

  bool checkPasswordMatch() {
    final password = passwordController.text;
    final confirmPassword = passwordConfirmController.text;
    return password == confirmPassword;
  }

  Future<void> addUserToFirestore() async {
    final email = emailController.text;
    final name = nameController.text;
    final String? uid;
    if (user != null) {
      uid = user?.uid;
    } else {
      uid = auth.currentUser?.uid;
    }
    final photoURL = user?.photoURL;
    final newUser = {
      'uid': uid,
      'name': name,
      'email': email,
      'photoURL': photoURL ?? 'https://i.stack.imgur.com/l60Hf.png',
    };
    // return users
    //     .add(newUser)
    //     .then((value) => print('User Added'))
    //     .catchError((error) => print("Failed to add user: $error"));
    try {
      await users.doc(uid).set(newUser);
      print('User Added');
    } catch (error) {
      print('Failed to add user: $error');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buat akun baru',
              style: secondaryTextStyle.copyWith(
                fontSize: 28,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Masukkan informasi Anda pada form di bawah ini untuk dapat menggunakan aplikasi Jaheet',
              style: subtitleTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    Widget namaInput() {
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
              controller: nameController,
              style: subtitleTextStyle,
              keyboardType: TextInputType.name,
              decoration: InputDecoration.collapsed(
                hintText: 'Nama Lengkap',
                hintStyle: subtitleTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    Widget emailInput() {
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
              controller: emailController,
              style: subtitleTextStyle,
              keyboardType: TextInputType.emailAddress,
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
              controller: passwordController,
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

    Widget passwordConfirmationInput() {
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
              controller: passwordConfirmController,
              style: subtitleTextStyle,
              obscureText: true,
              decoration: InputDecoration.collapsed(
                hintText: 'Konfirmasi Password',
                hintStyle: subtitleTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    Widget buttonSignUp() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            if (!checkPasswordMatch()) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: Text(
                      'Password dan konfirmasi password tidak cocok',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: reguler,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'OK',
                          style: navyTextStyle,
                        ),
                      ),
                    ],
                  );
                },
              );
              return;
            }

            setState(() {
              isLoading = true;
            });

            try {
              final email = emailController.text;
              final password = passwordController.text;

              await auth.createUserWithEmailAndPassword(
                  email: email, password: password);
              Navigator.pop(context);
            } catch (e) {
              print(e.toString());
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: Text('Email atau password sudah terdaftar',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: reguler,
                          )),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'OK',
                            style: navyTextStyle,
                          ),
                        ),
                      ],
                    );
                  });
            } finally {
              addUserToFirestore();
              setState(() {
                isLoading = false;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Daftar',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }

    Widget textLogin() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah punya akun?',
              style: primaryTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
              child: Text(
                'Masuk',
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
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.addUserToFirestoreFromGoogle();
            provider.googleLogin();
          },
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
                'Daftar dengan Google',
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
        body: StreamBuilder(
            stream: auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(primaryColor),
                  ),
                );
              } else if (snapshot.hasData) {
                return const MainScreen();
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            header(),
                            namaInput(),
                            emailInput(),
                            passwordInput(),
                            passwordConfirmationInput(),
                            buttonSignUp(),
                            textLogin(),
                            buttonLoginGoogle(),
                            SizedBox(
                              height: defaultMargin,
                            )
                          ],
                        ),
                      ),
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(primaryColor),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
