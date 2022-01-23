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

  // factory Message.fromMap(Map<String, dynamic> data) {
  //   var USERID = "";
  //   var CONTENT = "";
  //   var TIMESTAMP = Timestamp.now();
  //   var MESSAGETYPE = MessageType.text;
  //   var MESSAGESTATUS = MessageStatus.viewed;
  //   var ISSENDER = false;

  //   var map = Map.castFrom(data as Map<String, dynamic>);

  //   map.forEach((key, value) => {
  //         if (key == 'userId')
  //           {USERID = value as String}
  //         else if (key == 'content')
  //           {CONTENT = value as String}
  //         else if (key == 'timestamp')
  //           {TIMESTAMP = value as dynamic}
  //         else if (key == 'messageType')
  //           {MESSAGETYPE = value as MessageType}
  //         else if (key == 'messageStatus')
  //           {MESSAGESTATUS = value as MessageStatus}
  //         else if (key == 'isSender')
  //           {ISSENDER = value as bool}
  //       });

  //   return new Message(
  //       userId: USERID,
  //       content: CONTENT,
  //       timestamp: TIMESTAMP,
  //       messageType: MESSAGETYPE,
  //       messageStatus: MESSAGESTATUS,
  //       isSender: ISSENDER);
  // }

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
