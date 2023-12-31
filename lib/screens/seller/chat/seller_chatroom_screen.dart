import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant/theme.dart';
import '../../../services/chat_services.dart';

class SellerChatRoomScreen extends StatefulWidget {
  final String receiverName;
  final String receiverProfileImage;
  final String receiverID;
  const SellerChatRoomScreen({
    super.key,
    required this.receiverName,
    required this.receiverProfileImage,
    required this.receiverID,
  });

  @override
  State<SellerChatRoomScreen> createState() => _SellerChatRoomScreenState();
}

class _SellerChatRoomScreenState extends State<SellerChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final CollectionReference seller =
      FirebaseFirestore.instance.collection('seller');
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  String currentSellerId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserIsSeller();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> checkUserIsSeller() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      final userDoc = await users.doc(currentUser.uid).get();
      final sellerId = userDoc['sellerId'];

      if (sellerId != null) {
        final sellerSnapshot = await seller.doc('$sellerId').get();
        if (sellerSnapshot.exists) {
          // The user is a seller, you can handle this case here
          currentSellerId = sellerId.toString();
          print('User is a seller');
        } else {
          // The user is not a seller, you can handle this case here
          print('User is not a seller');
        }
      } else {
        // The user does not have a sellerId, so they are not a seller
        print('User is not a seller');
      }
    }
    setState(() {
      currentSellerId = currentSellerId;
    });
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverID,
        _messageController.text,
      );

      _messageController.clear();
    }
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: backgroundColor1,
      title: Row(
        children: [
          CircleAvatar(
            radius: 18.0,
            child: ClipOval(
              child: Image.network(
                widget.receiverProfileImage,
                fit: BoxFit.cover,
                width: 36.0,
                height: 36.0,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.receiverName,
                style: TextStyle(
                  color: primaryTextColor,
                  fontWeight: semiBold,
                ),
              ),
              Text(
                'Online',
                style: TextStyle(
                  color: primaryTextColor,
                  fontWeight: reguler,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
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
      elevation: 2,
    );
  }

  Widget chatBubble(String message, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor1,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              message,
              style: primaryTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              time,
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget receiverChatBubble(String message, String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor1,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              message,
              style: primaryTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              time,
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget chatTextField() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        left: 10,
        right: 10,
        top: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              //
            },
            icon: Icon(
              Icons.add_a_photo_rounded,
              color: secondaryColor,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _messageController,
              style: subtitleTextStyle,
              decoration: InputDecoration.collapsed(
                hintText: 'Tulis sesuatu...',
                hintStyle: subtitleTextStyle,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: const Icon(Icons.send),
            color: secondaryColor,
          ),
        ],
      ),
    );
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == currentSellerId)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    // Convert timestamp to DateTime
    var timestamp = (data['timestamp'] as Timestamp).toDate();

    // Format time to display only hours and minutes
    var formattedTime = DateFormat('HH:mm').format(timestamp);

    return Container(
      alignment: alignment,
      child: (data['senderId'] == currentSellerId)
          ? chatBubble(data['message'], formattedTime.toString())
          : receiverChatBubble(data['message'], formattedTime.toString()),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        // TODO: Kesalahan mengambil seller ID
        currentSellerId,
        // TODO: Ini seharusnya adlaah user ID
        widget.receiverID,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error $snapshot.error.toString()',
              style: primaryTextStyle);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return buildMessageItem(snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor3,
        resizeToAvoidBottomInset: false,
        appBar: appBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              Expanded(child: buildMessageList()),
              chatTextField(),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
