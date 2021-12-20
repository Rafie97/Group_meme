import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:meme_messenger/models/ChatMessage.dart';

class Convo {
  final String convoId;
  final List<ChatMessage> messages;

  factory Convo.fromMap(Map<String, dynamic> data) {
    final List<ChatMessage> listo = [];
    data.forEach((key, value) => {
          listo.add(ChatMessage(
            userId: key,
            content: value['content'],
            timestamp: value['timestamp'],
            messageType: value['messageType'],
            messageStatus: value['messageStatus'],
            isSender: value['isSender'],
          ))
        });
    print("YOOOO");
    print(listo);
    return new Convo(
      convoId: '1',
      messages: listo,
    );
  }

  Convo({
    required this.convoId,
    required this.messages,
  });
}
