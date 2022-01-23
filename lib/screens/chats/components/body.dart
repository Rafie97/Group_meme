import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_messenger/components/filled_outline_button.dart';
import 'package:meme_messenger/constants.dart';
import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:meme_messenger/models/Convo.dart';
import 'package:meme_messenger/repositories/message_repository.dart';
import 'package:meme_messenger/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';
import 'chat_card.dart';

class Body extends HookConsumerWidget {
  Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final convos = useState<List<Convo>>([]);

    useEffect(() {
      ref.read(messageRepoProvider).getConvos().listen((snap) {
        convos.value = snap.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          return Convo(
            name: data['name'] as String,
            convoId: doc.id,
            lastMessage: Message(
                userName: data['lastMessage']['userName'],
                userId: data['lastMessage']['userId'],
                content: data['lastMessage']['content'],
                timestamp: data['lastMessage']['timestamp']),
          );
        }).toList();
      });
    }, []);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(kDefaultPadding),
          // color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: "Recent Message"),
              SizedBox(width: kDefaultPadding),
              FillOutlineButton(
                press: () {},
                text: "Active",
                isFilled: false,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: convos.value.length,
            itemBuilder: (context, index) => ChatCard(
              chat: convos.value[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MessageScreen(convo: convos.value[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
