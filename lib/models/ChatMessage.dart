import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  String userId;
  String content;
  dynamic timestamp;
  ChatMessageType? messageType;
  MessageStatus? messageStatus;
  bool isSender;

  factory ChatMessage.fromMap(Map<String, dynamic> data) {
    final ChatMessage msg = ChatMessage(
      userId: '1',
      content: 'dsf',
      timestamp: Timestamp.now(),
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.not_sent,
      isSender: true,
    );

    data.forEach((key, value) => {
          if (key == 'userId')
            {msg.userId = value as String}
          else if (key == 'content')
            {msg.content = value as String}
          else if (key == 'timestamp')
            {msg.timestamp = value as dynamic}
          else if (key == 'messageType')
            {msg.messageType = value as ChatMessageType}
          else if (key == 'messageStatus')
            {msg.messageStatus = value as MessageStatus}
          else if (key == 'isSender')
            {msg.isSender = value as bool}
        });

    print("YOOOO");
    print(data);

    return msg;
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
