import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meme_messenger/screens/chats/chats_screen.dart';

class AuthService {
  final FirebaseAuth _auth;
  AuthService(this._auth);

  void NavToChats(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatsScreen(),
      ),
    );
  }

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<void> signOut(BuildContext context) async {
    _auth.signOut();
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  Future<void> signInAnon(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
      NavToChats(context);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await _auth.signInWithCredential(credential);
      }
      NavToChats(context);
    } catch (e) {
      print(e.toString());
    }
  }
}
