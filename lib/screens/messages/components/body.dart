import 'package:meme_messenger/constants.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/controllers/auth_controller.dart';
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
    final user = ref.watch(authControllerProvider);
    final newConvo = useState<Convo?>(null);

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
          final isSender = data['userId'] == user?.uid;
          return Message(
              userId: data['userId'],
              content: data['content'],
              timestamp: data['timestamp'],
              isSender: isSender);
        }).toList();
        newConvo.value = Convo(
          convoId: convo.convoId,
          lastMessage: convo.lastMessage,
          messages: streamedMessages.value,
        );
      });
    }, [convo.lastMessage]);

    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SingleChildScrollView(
                  child: Column(children: [
                if (newConvo.value != null)
                  for (int i = 0; i < newConvo.value!.messages.length - 1; i++)
                    ChatMessage(
                      key: GlobalKey(),
                      message: newConvo.value!.messages[i],
                    ),
                ChatMessage(
                  key: lastMessageKey.value,
                  message: newConvo.value!.lastMessage,
                )
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
