import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:meme_messenger/models/ChatMessage.dart';

class Convo {
  final String convoId;
  final List<ChatMessage> messages;
  final ChatMessage lastMessage;

  Convo({
    required this.convoId,
    required this.messages,
    required this.lastMessage,
  });
}
