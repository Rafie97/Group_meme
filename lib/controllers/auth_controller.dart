import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_messenger/repositories/auth_repository.dart';

final authControllerProvider =
    StateNotifierProvider((ref) => AuthController(ref.read));

class AuthController extends StateNotifier<User?> {
  final Reader _reader;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._reader) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _reader(authRepositoryProvider)
        .authStateChanges
        .listen((user) => state = user);
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  // void appStarted() async {
  //   final user = await _reader(authRepositoryProvider).getCurrentUser();
  //   if (user == null) {
  //     await _reader(authRepositoryProvider).signInAnonymously(context);
  //   }
  // }

  void signInAnon(BuildContext context) async {
    await _reader(authRepositoryProvider).signInAnonymously(context);
  }

  void signInWithGoogle(BuildContext context) async {
    await _reader(authRepositoryProvider).signInWithGoogle(context);
  }

  void signOut(BuildContext context) async {
    await _reader(authRepositoryProvider).signOut(context);
  }
}
