import 'package:meme_messenger/models/ChatMessage.dart';

class Convo {
  final String convoId, name, image;
  final List<Message> messages;
  final Message lastMessage;

  Convo(
      {this.name = '',
      this.image = '',
      required this.convoId,
      this.messages = const [],
      required this.lastMessage});
}
