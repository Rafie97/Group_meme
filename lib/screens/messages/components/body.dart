import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meme_messenger/constants.dart';
import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/models/Convo.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends HookWidget {
  final Convo convo;
  Body({
    Key? key,
    required this.convo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lastMessageKey = useState(new GlobalKey());

    useEffect(() {
      if (lastMessageKey.value.currentContext != null) {
        print('CONTEXXXXXXXXXX + ${lastMessageKey.value.currentContext}');
        Scrollable.ensureVisible(lastMessageKey.value.currentContext!);
      }
    }, [convo.lastMessage]);

    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SingleChildScrollView(
                  child: Column(children: [
                for (int i = 0; i < convo.messages.length - 1; i++)
                  ChatMessage(
                    key: GlobalKey(),
                    message: convo.messages[i],
                  ),
                ChatMessage(
                  key: lastMessageKey.value,
                  message: convo.lastMessage,
                ),
              ]))),
        ),
        Consumer(builder: (context, User? user, child) {
          final userId = user?.uid ?? '';
          return ChatInputField(
            userId: userId,
            lastMessageKey: lastMessageKey.value,
          );
        })
      ],
    );
  }
}
