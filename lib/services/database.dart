import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // static Stream<List<ChatMessage>> streamMessages(
  //     AsyncSnapshot<QuerySnapshot> snapshot) {
  //   var map = snapshot.data!.docs.map((DocumentSnapshot document) {
  //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  //     return ListTile(
  //       title: Text(data['userId']),
  //       subtitle: Text(data['content']),
  //     );
  //   }).toList();

  //   return map;
  // }

  static Future<DocumentReference> sendMessage(String message) {
    return _db
        .collection('chats')
        .doc('meme_channel_1')
        .collection('messages')
        .add({
      'content': message,
      'userId': '1',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
