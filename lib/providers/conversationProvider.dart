import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/models/Convo.dart';
import 'package:meme_messenger/screens/messages/components/body.dart';
import 'package:provider/provider.dart';
import 'package:meme_messenger/models/ChatMessage.dart';

class ConversationProvider extends StatelessWidget {
  final lastMessageKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final docString =
        user != null && user.isAnonymous ? 'all_channel_1' : 'meme_channel_1';
    final Stream<QuerySnapshot> _convoStream = FirebaseFirestore.instance
        .collection('chats')
        .doc(docString)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
    return Consumer(builder: (context, User? user, child) {
      final userId = user?.uid ?? '';
      return StreamBuilder<QuerySnapshot>(
        stream: _convoStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          final messages = snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            final bool isSendr =
                userId.isNotEmpty && data['userId'].toString() == userId;
            return Message(
              userId: data['userId'],
              content: data['content'],
              timestamp: data['timestamp'],
              isSender: isSendr,
            );
          }).toList();

          final convo = new Convo(
              convoId: '1', messages: messages, lastMessage: messages.last);

          return Body(convo: convo);
        },
      );
    });
  }
}
