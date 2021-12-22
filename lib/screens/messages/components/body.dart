import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meme_messenger/constants.dart';
import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/models/Convo.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  final lastMessageKey = new GlobalKey();
  final Convo convo;
  Body({
    Key? key,
    required this.convo,
  }) : super(key: key);

  // Scrollable.ensureVisible(lastMessageKey.currentContext!);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ListView(children: [
                ...convo.messages.map((message) => Message(message: message)),
                Message(message: convo.lastMessage, key: lastMessageKey),
              ])),
        ),
        ChatInputField(),
      ],
    );
  }
}
