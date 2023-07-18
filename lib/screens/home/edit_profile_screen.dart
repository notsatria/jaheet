import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constant/theme.dart';

class EditProfileScreen extends StatelessWidget {
  static const routeName = '/edit-profile';
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: semiBold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check,
              color: primaryColor,
            ),
          ),
        ],
        elevation: 2,
      );
    }

    Widget profileImageEdit({required String photoURL}) {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  photoURL,
                ),
              ),
              Positioned(
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt,
                      color: backgroundColor1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget editInputField(
        {required String title, required String initialValue}) {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: TextFormField(
          initialValue: initialValue,
          cursorColor: primaryColor,
          style: primaryTextStyle,
          decoration: InputDecoration(
            labelText: title,
            labelStyle: subtitleTextStyle.copyWith(
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              FutureBuilder(
                future: users.doc(user.uid).get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return profileImageEdit(
                      photoURL: snapshot.data!.get('photoURL'),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              FutureBuilder(
                future: users.doc(user.uid).get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return editInputField(
                      title: 'Nama',
                      initialValue: snapshot.data!.get('name'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              FutureBuilder(
                future: users.doc(user.uid).get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return editInputField(
                      title: 'Username',
                      initialValue: snapshot.data!.get('name'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              FutureBuilder(
                future: users.doc(user.uid).get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return editInputField(
                      title: 'Email',
                      initialValue: snapshot.data!.get('email'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
