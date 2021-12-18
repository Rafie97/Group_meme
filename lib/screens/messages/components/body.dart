import 'package:meme_messenger/constants.dart';
import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ChatMessage> _convo = Provider.of<List<ChatMessage>>(context);

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: _convo.length,
              itemBuilder: (context, index) => Message(message: _convo[index]),
            ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}
