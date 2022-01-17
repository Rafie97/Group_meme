import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_messenger/components/primary_button.dart';
import 'package:meme_messenger/constants.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/controllers/auth_controller.dart';

class SigninOrSignupScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  ref
                      .read(authControllerProvider.notifier)
                      .signInWithGoogle(context);
                },
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              PrimaryButton(
                text: "Sign In Anonymously",
                press: () {
                  ref.read(authControllerProvider.notifier).signInAnon(context);
                },
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
