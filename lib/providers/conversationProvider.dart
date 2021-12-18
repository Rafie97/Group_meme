import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/screens/chats/components/body.dart';
import 'package:meme_messenger/screens/messages/message_screen.dart';
import 'package:provider/provider.dart';

import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:meme_messenger/services/database.dart';

class ConversationProvider extends StatelessWidget {
  const ConversationProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ChatMessage>>.value(
        initialData: [] as List<ChatMessage>,
        value: Database.streamMessages(),
        child: Body());
  }
}
