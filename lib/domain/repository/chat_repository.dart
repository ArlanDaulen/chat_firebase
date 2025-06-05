import 'package:chat_firebase/domain/entities/message_entity.dart';
import 'package:chat_firebase/domain/entities/user_entity.dart';

abstract class ChatRepository {
  Stream<List<UserEntity>> getUsers();
  Future<void> sendMessage(MessageEntity message);
  Stream<List<MessageEntity>> getMessages(String userId, otherUserId);
}
