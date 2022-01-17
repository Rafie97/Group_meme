import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meme_messenger/constants.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/providers/chatsProvider.dart';
import 'package:meme_messenger/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatsScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedIndex = useState(1);
    return Scaffold(
      appBar: buildAppBar(context, ref),
      body: ChatsProvider(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.person_add_alt_1,
          color: Color(0xFF969696),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(
      ValueNotifier<int> _selectedIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex.value,
      onTap: (value) {
        _selectedIndex.value = value;
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          label: "Profile",
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Padding(child: Text("Chats"), padding: EdgeInsets.only(left: 5)),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            ref.read(authControllerProvider.notifier).signOut(context);
          },
        ),
      ],
    );
  }
}
