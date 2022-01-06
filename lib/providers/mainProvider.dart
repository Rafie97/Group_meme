import 'package:meme_messenger/providers/loginRouter.dart';
import 'package:meme_messenger/screens/welcome/welcome_screen.dart';
import 'package:meme_messenger/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

/////// NEXT: https://github.com/Xenon-Labs/Flutter-Development/tree/master/chat_app/lib/screens/messaging

class MainProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.authStateChanges();
    return StreamProvider<User?>.value(
        initialData: null,
        value: user,
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: lightThemeData(context),
          darkTheme: darkThemeData(context),
          home: LoginRouter(),
        ));
  }
}
