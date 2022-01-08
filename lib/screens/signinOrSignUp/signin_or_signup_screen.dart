import 'package:meme_messenger/components/primary_button.dart';
import 'package:meme_messenger/constants.dart';
import 'package:meme_messenger/screens/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/services/auth.dart';
import 'package:provider/provider.dart';

class SigninOrSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Spacer(flex: 2),
              Image.asset(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? "assets/images/Logo_light.png"
                    : "assets/images/Logo_dark.png",
                height: 146,
              ),
              Spacer(),
              PrimaryButton(
                color: kSecondaryColor,
                text: "Sign In With Google",
                press: () {
                  context.read<AuthService>().signInWithGoogle(context);
                },
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              PrimaryButton(
                  text: "Sign In Anonymously",
                  press: () {
                    context.read<AuthService>().signInAnon(context);
                  }),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
