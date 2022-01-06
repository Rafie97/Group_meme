import 'package:meme_messenger/models/ChatMessage.dart';

class Convo {
  final String convoId;
  final List<Message> messages;
  final Message lastMessage;

  Convo({
    required this.convoId,
    required this.messages,
    required this.lastMessage,
  });
}
