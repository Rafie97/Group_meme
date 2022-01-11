import 'package:meme_messenger/constants.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/models/Convo.dart';
import 'package:meme_messenger/providers/conversationProvider.dart';

import 'components/body.dart';

class MessageScreen extends StatelessWidget {
  final Convo convo;
  MessageScreen({required this.convo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ConversationProvider(convoId: convo.convoId),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                convo.name,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
