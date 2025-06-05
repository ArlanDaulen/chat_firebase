import 'package:chat_firebase/data/datasource/chat_remote_datasource.dart';
import 'package:chat_firebase/data/models/message_model.dart';
import 'package:chat_firebase/domain/entities/message_entity.dart';
import 'package:chat_firebase/domain/entities/user_entity.dart';
import 'package:chat_firebase/domain/repository/chat_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<MessageEntity>> getMessages(String userId, otherUserId) {
    return remoteDataSource
        .getMessages(userId, otherUserId)
        .map(
          (messages) => messages.map((message) => message.toEntity()).toList(),
        );
  }

  @override
  Stream<List<UserEntity>> getUsers() {
    return remoteDataSource.getUsers().map(
      (users) => users.map((user) => user.toEntity()).toList(),
    );
  }

  @override
  Future<void> sendMessage(MessageEntity message) async {
    final messageModel = MessageModel.fromEntity(message);
    await remoteDataSource.sendMessage(messageModel);
  }
}
