import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meme_messenger/constants.dart';
import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  final List<ChatMessage> convoStream;
  const Body({
    Key? key,
    required this.convoStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: convoStream.length,
              itemBuilder: (context, index) =>
                  Message(message: convoStream[index]),
            ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}
