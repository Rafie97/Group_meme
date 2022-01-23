import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_messenger/constants.dart';
import 'package:meme_messenger/controllers/message_controller.dart';

class ChatInputField extends ConsumerWidget {
  final myController = TextEditingController();
  final String convoId;
  final GlobalKey lastMessageKey;

  ChatInputField(
      {Key? key, required this.convoId, required this.lastMessageKey})
      : super(key: key);

  void dispose() {
    myController.dispose();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void sendMessage(String message) {
      ref.read(messageProvider.notifier).sendMessage(convoId, message);
      myController.clear();
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Icon(Icons.insert_photo, size: 30, color: kPrimaryColor),
            SizedBox(width: kDefaultPadding / 2),
            Icon(Icons.poll, size: 30, color: kPrimaryColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      size: 30,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, size: 30, color: kPrimaryColor),
              onPressed: () => sendMessage(myController.text),
            ),
          ],
        ),
      ),
    );
  }
}
