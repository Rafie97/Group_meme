import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_messenger/providers/mainProvider.dart';
import 'package:flutter/material.dart';
import 'package:meme_messenger/hiddenConfig/initFirebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  runApp(ProviderScope(child: MainApp()));
}
