import 'package:meme_messenger/screens/chats/chats_screen.dart';
import 'package:meme_messenger/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    print("THIS THE GOT DAM USR: $user");
    if (user != null) {
      return ChatsScreen();
    } else {
      return WelcomeScreen();
    }
  }
}
