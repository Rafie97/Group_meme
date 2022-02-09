import 'package:meme_messenger/models/Message.dart';

class Convo {
  final String convoId, name, image;
  final List<Message> messages;
  final Message lastMessage;

  Convo(
      {this.name = '',
      this.image = '',
      this.convoId = '',
      this.messages = const [],
      required this.lastMessage});
}
