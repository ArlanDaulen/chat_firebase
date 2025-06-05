import 'package:chat_firebase/data/models/message_model.dart';
import 'package:chat_firebase/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class ChatRemoteDataSource {
  Stream<List<UserModel>> getUsers();
  Future<void> sendMessage(MessageModel message);
  Stream<List<MessageModel>> getMessages(String userId, otherUserId);
}

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final _fireStore = FirebaseFirestore.instance;

  @override
  Stream<List<UserModel>> getUsers() {
    return _fireStore
        .collection('users')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => UserModel.fromJson(doc.data()))
                  .toList(),
        );
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    final chatRoomId = _getChatRoomId(message.senderId!, message.receiverId!);

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toJson());
  }

  @override
  Stream<List<MessageModel>> getMessages(String userId, otherUserId) {
    final chatRoomId = _getChatRoomId(userId, otherUserId);
    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => MessageModel.fromJson(doc.data()))
                  .toList(),
        );
  }
}

String _getChatRoomId(String userId, String otherUserId) {
  final ids = [userId, otherUserId];
  ids.sort();
  return ids.join('_');
}
