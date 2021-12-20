import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String userId;
  final String content;
  final dynamic timestamp;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  factory ChatMessage.fromMap(Map<String, dynamic> data) {
    var USERID = "";
    var CONTENT = "";
    var TIMESTAMP = Timestamp.now();
    var MESSAGETYPE = ChatMessageType.text;
    var MESSAGESTATUS = MessageStatus.viewed;
    var ISSENDER = false;

    var map = Map.castFrom(data as Map<String, dynamic>);

    map.forEach((key, value) => {
          if (key == 'userId')
            {USERID = value as String}
          else if (key == 'content')
            {CONTENT = value as String}
          else if (key == 'timestamp')
            {TIMESTAMP = value as dynamic}
          else if (key == 'messageType')
            {MESSAGETYPE = value as ChatMessageType}
          else if (key == 'messageStatus')
            {MESSAGESTATUS = value as MessageStatus}
          else if (key == 'isSender')
            {ISSENDER = value as bool}
        });

    return new ChatMessage(
        userId: USERID,
        content: CONTENT,
        timestamp: TIMESTAMP,
        messageType: MESSAGETYPE,
        messageStatus: MESSAGESTATUS,
        isSender: ISSENDER);
  }

  ChatMessage({
    required this.userId,
    required this.content,
    this.timestamp,
    this.messageType = ChatMessageType.text,
    this.messageStatus = MessageStatus.viewed,
    this.isSender = false,
  });
}

List demeChatMessages = [
  ChatMessage(
    userId: "2",
    content: "Hi Sajol,",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    userId: "2",
    content: "Hello, How are you?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    userId: "2",
    content: "",
    messageType: ChatMessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    userId: "2",
    content: "",
    messageType: ChatMessageType.video,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessage(
    userId: "2",
    content: "Error happend",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_sent,
    isSender: false,
  ),
  ChatMessage(
    userId: "2",
    content: "This looks great man!!",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    userId: "2",
    content: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
];
