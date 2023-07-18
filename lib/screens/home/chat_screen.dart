import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/screens/home/chatroom_screen.dart';
import 'package:jahitin/screens/home/main_screen.dart';

import '../../constant/theme.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference sellers =
        FirebaseFirestore.instance.collection('seller');

    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Chat',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: semiBold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, MainScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
          ),
        ),
        elevation: 2,
      );
    }

    Widget searchBar() {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        height: 45,
        decoration: BoxDecoration(
          color: backgroundColor4,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: subtitleTextColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextFormField(
                style: subtitleTextStyle,
                decoration: InputDecoration.collapsed(
                  hintText: 'Search',
                  hintStyle: subtitleTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget chatBar({required String photoURL, required String name}) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ChatRoomScreen.routeName);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                child: ClipOval(
                  child: Image.network(
                    photoURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      'Saya ingin memesan jasa jahit Anda',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Hari ini',
                style: subtitleTextStyle.copyWith(
                  fontSize: 12,
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
        appBar: appBar(),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            children: [
              searchBar(),
              SizedBox(
                height: defaultMargin,
              ),
              StreamBuilder(
                stream: sellers.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(primaryColor),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];
                          return chatBar(
                            photoURL: data['profileImage'],
                            name: data['name'],
                          );
                        },
                      ),
                    );
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
