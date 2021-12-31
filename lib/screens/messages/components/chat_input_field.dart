import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/constants.dart';
import 'package:meme_messenger/screens/messages/components/message.dart';

class ChatInputField extends StatefulWidget {
  final GlobalKey lastMessageKey;
  final String userId;
  const ChatInputField(
      {Key? key, required this.lastMessageKey, required this.userId})
      : super(key: key);
  @override
  _ChatInputState createState() =>
      _ChatInputState(lastMessageKey: lastMessageKey, userId: userId);
}

class _ChatInputState extends State<ChatInputField> {
  final myController = TextEditingController();
  final GlobalKey lastMessageKey;
  final String userId;

  _ChatInputState({required this.lastMessageKey, required this.userId});

  Future<DocumentReference> sendMessage(String message) {
    myController.clear();
    // Scrollable.ensureVisible(lastMessageKey.currentContext!);
    return FirebaseFirestore.instance
        .collection('chats')
        .doc('meme_channel_1')
        .collection('messages')
        .add({
      'content': message,
      'userId': this.userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
