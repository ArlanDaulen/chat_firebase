import 'package:chat_firebase/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsers() {
    try {
      return _fireStore
          .collection('users')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> sendMessage({
    required String receiverId,
    required String message,
  }) async {
    try {
      final currentUserId = _auth.currentUser?.uid;
      final currentUserEmail = _auth.currentUser?.email;

      final newMessage = MessageModel(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: DateTime.now().toString(),
      );

      final chatRoomId = _getChatRoomId(currentUserId!, receiverId);

      await _fireStore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    final chatRoomId = _getChatRoomId(userId, otherUserId);
    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }
}

String _getChatRoomId(String userId, String otherUserId) {
  final ids = [userId, otherUserId];
  ids.sort();
  return ids.join('_');
}
