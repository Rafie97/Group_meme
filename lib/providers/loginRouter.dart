import 'package:meme_messenger/controllers/auth_controller.dart';
import 'package:meme_messenger/screens/chats/chats_screen.dart';
import 'package:meme_messenger/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginRouter extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    print("THIS THE GOT DAM USR: $user");
    if (user != null) {
      return ChatsScreen();
    } else {
      return WelcomeScreen();
    }
  }
}
