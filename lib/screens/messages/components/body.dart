import 'package:meme_messenger/constants.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:meme_messenger/models/Convo.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meme_messenger/repositories/message_repository.dart';
import 'chat_input_field.dart';
import 'message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Body extends HookConsumerWidget {
  final Convo convo;

  Body({Key? key, required this.convo}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastMessageKey = useState(new GlobalKey());
    final convoIdState = useState<String>('');
    final streamedMessages = useState<List<Message>>([]);

    useEffect(() {
      convoIdState.value = convo.convoId;
    }, []);

    useEffect(() {
      if (lastMessageKey.value.currentContext != null) {
        Scrollable.ensureVisible(lastMessageKey.value.currentContext!);
      }
      ref.read(messageRepoProvider).getMessages(convo.convoId).listen((snap) {
        streamedMessages.value = snap.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          return Message(
              userId: data['userId'],
              content: data['content'],
              timestamp: data['timestamp']);
        }).toList();
      });
    }, [convo.lastMessage]);

    final newConvo = Convo(
      convoId: convo.convoId,
      lastMessage: convo.lastMessage,
      messages: streamedMessages.value,
    );

    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SingleChildScrollView(
                  child: Column(children: [
                for (int i = 0; i < newConvo.messages.length - 1; i++)
                  ChatMessage(
                    key: GlobalKey(),
                    message: newConvo.messages[i],
                  ),
                ChatMessage(
                  key: lastMessageKey.value,
                  message: newConvo.lastMessage,
                ),
              ]))),
        ),
        ChatInputField(
          convoId: convoIdState.value,
          lastMessageKey: lastMessageKey.value,
        )
      ],
    );
  }
}
