import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meme_messenger/controllers/auth_controller.dart';
import 'package:meme_messenger/models/ChatMessage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_messenger/providers/general_providers.dart';

abstract class BaseMessageRepository {
  Stream<List<Message>> getMessages(String chatId);
  void sendMessage(String chatId, String message);
}

final messageRepositoryProvider =
    Provider<MessageRepository>((ref) => MessageRepository(ref.read));

class MessageRepository implements BaseMessageRepository {
  final Reader _read;
  MessageRepository(this._read);

  @override
  Stream<List<Message>> getMessages(String chatId) {
    final _firestore = _read(firebaseFirestoreProvider);
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Message(
          userId: data['userId'],
          content: data['content'],
          timestamp: data['timestamp'],
        );
      }).toList();
    });
  }

  void sendMessage(String chatId, String message) {
    // myController.clear();
    final user = _read(authControllerProvider.notifier).state;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'content': message,
        'userId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
}
