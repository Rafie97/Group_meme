import 'package:meme_messenger/components/filled_outline_button.dart';
import 'package:meme_messenger/constants.dart';
import 'package:meme_messenger/models/Chat.dart';
import 'package:meme_messenger/models/Convo.dart';
import 'package:meme_messenger/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';

import 'chat_card.dart';

class Body extends StatelessWidget {
  final List<Convo> chats;

  Body({required this.chats});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(kDefaultPadding),
          // color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: "Recent Message"),
              SizedBox(width: kDefaultPadding),
              FillOutlineButton(
                press: () {},
                text: "Active",
                isFilled: false,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chats[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageScreen(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
