import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/screens/messages/components/body.dart';
import 'package:meme_messenger/screens/messages/message_screen.dart';
import 'package:provider/provider.dart';

import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:meme_messenger/services/database.dart';

class ConversationProvider extends StatelessWidget {
  final Stream<QuerySnapshot> _convoStream = FirebaseFirestore.instance
      .collection('chats')
      .doc("meme_channel_1")
      .collection('messages')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _convoStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        final convo = snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return ChatMessage(
            userId: data['userId'],
            content: data['content'],
          );
        }).toList();

        return Body(convoStream: convo);
      },
    );
  }
}
