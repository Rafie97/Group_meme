import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:meme_messenger/repositories/message_repository.dart';

final messageProvider =
    StateNotifierProvider((ref) => MessageController(ref.read));

class MessageController extends StateNotifier<List<Message>?> {
  final Reader _reader;
  StreamSubscription<List<Message>?>? _messageSubscription;

  MessageController(this._reader) : super(null);

  void getMessages(String chatId) {
    _messageSubscription?.cancel();
    _messageSubscription = _reader(messageRepositoryProvider)
        .getMessages(chatId)
        .listen((msgs) => state = msgs);
  }

  void sendMessage(String chatId, String message) {
    _reader(messageRepositoryProvider).sendMessage(chatId, message);
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }
}
