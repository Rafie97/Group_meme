import 'package:firebase_auth/firebase_auth.dart';
import 'package:meme_messenger/constants.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/controllers/auth_controller.dart';
import 'package:meme_messenger/controllers/message_controller.dart';
import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:meme_messenger/models/Convo.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'chat_input_field.dart';
import 'message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;

class Body extends riverpod.HookConsumerWidget {
  final Convo convo;

  Body({Key? key, required this.convo}) : super(key: key);
  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    ref.read(messageProvider.notifier).getMessages(convo.convoId);
    final streamedMessages = ref.watch(messageProvider) as List<Message>;
    final user = ref.watch(authControllerProvider) as User;
    final newConvo = Convo(
      convoId: convo.convoId,
      lastMessage: convo.lastMessage,
      messages: streamedMessages,
    );
    return BodyHook(
      user: user,
      convo: newConvo,
    );
  }
}

class BodyHook extends HookWidget {
  final Convo convo;
  final User user;
  BodyHook({
    Key? key,
    required this.user,
    required this.convo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lastMessageKey = useState(new GlobalKey());

    useEffect(() {
      if (lastMessageKey.value.currentContext != null) {
        Scrollable.ensureVisible(lastMessageKey.value.currentContext!);
      }
    }, [convo.lastMessage]);

    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SingleChildScrollView(
                  child: Column(children: [
                for (int i = 0; i < convo.messages.length - 1; i++)
                  ChatMessage(
                    key: GlobalKey(),
                    message: convo.messages[i],
                  ),
                ChatMessage(
                  key: lastMessageKey.value,
                  message: convo.lastMessage,
                ),
              ]))),
        ),
        ChatInputField(
          convo: convo,
          lastMessageKey: lastMessageKey.value,
        )
      ],
    );
  }
}
