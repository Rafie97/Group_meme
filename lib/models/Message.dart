enum MessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class Message {
  final String userId;
  final String userName;
  final String content;
  final dynamic timestamp;
  final MessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  Message({
    required this.userId,
    required this.content,
    this.userName = "Anonymous",
    this.timestamp,
    this.messageType = MessageType.text,
    this.messageStatus = MessageStatus.viewed,
    this.isSender = false,
  });
}
