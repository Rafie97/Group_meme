import 'package:meme_messenger/components/primary_button.dart';
import 'package:meme_messenger/constants.dart';
import 'package:meme_messenger/screens/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SigninOrSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void NavToChats() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatsScreen(),
        ),
      );
    }

    Future<UserCredential> signInWithGoogle() async {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
        NavToChats();
        return await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        NavToChats();
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    }

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
                press: signInWithGoogle,
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              PrimaryButton(
                  text: "Sign In Anonymously",
                  press: () {
                    FirebaseAuth.instance.signInAnonymously();
                  }),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
