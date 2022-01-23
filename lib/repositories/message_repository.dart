import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meme_messenger/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_messenger/providers/general_providers.dart';

abstract class BaseMessageRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getConvos();
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String chatId);
  void sendMessage(String chatId, String message);
}

final messageRepoProvider =
    Provider<MessageRepository>((ref) => MessageRepository(ref.read));

class MessageRepository implements BaseMessageRepository {
  final Reader _read;
  MessageRepository(this._read);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getConvos() {
    final _firestore = _read(firebaseFirestoreProvider);
    return _firestore.collection('chats').snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String chatId) {
    final _firestore = _read(firebaseFirestoreProvider);
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  void sendMessage(String chatId, String message) {
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
      FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        'lastMessage': {
          'content': message,
          'timestamp': FieldValue.serverTimestamp(),
          'userId': user.uid,
        }
      });
    }
  }
}
