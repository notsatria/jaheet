import 'package:flutter/material.dart';

import '../../constant/theme.dart';

class ChatRoomScreen extends StatefulWidget {
  static const routeName = '/chat-room-screen';

  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: backgroundColor1,
      title: Row(
        children: [
          CircleAvatar(
            radius: 18.0,
            child: ClipOval(
              child: Image.asset(
                'assets/images/userprofile.jpg',
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
                'Nama Tailor',
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

  Widget senderChatBubble(String message, String time) {
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
              controller: _textEditingController,
              style: subtitleTextStyle,
              decoration: InputDecoration.collapsed(
                hintText: 'Tulis sesuatu...',
                hintStyle: subtitleTextStyle,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle sending the message
              String message = _textEditingController.text;
              // Perform actions with the message (e.g., send it to the server)
              print('Sending message: $message');
              // Clear the text field
              _textEditingController.clear();
            },
            icon: const Icon(Icons.send),
            color: secondaryColor,
          ),
        ],
      ),
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
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    senderChatBubble('Halo, saya ingin memesan', '10:00'),
                    receiverChatBubble('Halo, saya ingin memesan', '10:00'),
                    senderChatBubble('Halo, saya ingin memesan', '10:00'),
                    receiverChatBubble('Halo, saya ingin memesan', '10:00'),
                    senderChatBubble('Halo, saya ingin memesan', '10:00'),
                    receiverChatBubble('Halo, saya ingin memesan', '10:00'),
                  ],
                ),
              ),
              chatTextField(),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
