import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_messenger/providers/general_providers.dart';
import 'package:meme_messenger/screens/chats/chats_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signInAnonymously(BuildContext context);
  Future<void> signInWithGoogle(BuildContext context);
  User? getCurrentUser();
  Future<void> signOut(BuildContext context);
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.read));

void NavToChats(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChatsScreen(),
    ),
  );
}

class AuthRepository implements BaseAuthRepository {
  final Reader _read;
  const AuthRepository(this._read);

  @override
  Stream<User?> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();

  @override
  User? getCurrentUser() {
    return _read(firebaseAuthProvider).currentUser;
  }

  @override
  Future<void> signInAnonymously(BuildContext context) async {
    try {
      await _read(firebaseAuthProvider).signInAnonymously();
      NavToChats(context);
    } catch (error) {
      print("signInAnonymously failed: $error");
    }
  }

  @override
  Future<void> signOut(BuildContext context) async {
    try {
      await _read(firebaseAuthProvider).signOut();
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      print("signOut failed: $error");
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
        await _read(firebaseAuthProvider).signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await _read(firebaseAuthProvider).signInWithCredential(credential);
      }
      NavToChats(context);
    } catch (e) {
      print(e.toString());
    }
  }
}
