import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:meme_messenger/models/Convo.dart';
import 'package:meme_messenger/screens/chats/components/body.dart';

class ChatsProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _convoStream =
        FirebaseFirestore.instance.collection('chats').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _convoStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        final chats = snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return new Convo(
            name: data['name'] as String,
            convoId: document.id,
            lastMessage: new Message(
                userId: data['lastMessage']['userName'],
                content: data['lastMessage']['content']),
          );
        }).toList();

        return Body(chats: chats);
      },
    );
  }
}
