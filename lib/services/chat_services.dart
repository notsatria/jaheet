import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jahitin/models/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final CollectionReference seller =
      FirebaseFirestore.instance.collection('seller');
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  //  SEND MESSAGE
  Future<void> sendMessage(String receiverId, String message) async {
    String currentUserId = '';
    String currentUsername = '';
    final Timestamp timestamp = Timestamp.now();

    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      final userDoc = await users.doc(currentUser.uid).get();
      final sellerId = userDoc['sellerId'];

      if (sellerId != null) {
        final sellerSnapshot = await seller.doc('$sellerId').get();
        if (sellerSnapshot.exists) {
          // The user is a seller, you can handle this case here
          currentUserId = sellerId.toString();
          currentUsername = sellerSnapshot['name'];
          print('User is a seller');
        } else {
          // The user is not a seller, you can handle this case here
          currentUserId = _firebaseAuth.currentUser!.uid;
          currentUsername = userDoc['name'];
          print('User is not a seller');
        }
      } else {
        // The user does not have a sellerId, so they are not a seller
        print('User is not a seller');
      }
    }

    Message newMessage = Message(
      senderId: currentUserId,
      senderUsername: currentUsername,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _fireStore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // GET MESSAGE
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _fireStore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
