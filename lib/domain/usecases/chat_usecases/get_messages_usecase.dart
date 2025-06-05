import 'package:chat_firebase/domain/entities/message_entity.dart';
import 'package:chat_firebase/domain/repository/chat_repository.dart';
import 'package:chat_firebase/domain/usecases/base_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class GetMessagesUseCaseParams extends Equatable {
  final String userId;
  final String otherUserId;
  const GetMessagesUseCaseParams({
    required this.userId,
    required this.otherUserId,
  });

  @override
  List<Object?> get props => [userId, otherUserId];
}

@injectable
class GetMessagesUseCase
    implements UseCase<Stream<List<MessageEntity>>, GetMessagesUseCaseParams> {
  final ChatRepository repository;

  GetMessagesUseCase({required this.repository});

  @override
  Future<Stream<List<MessageEntity>>> call(
    GetMessagesUseCaseParams params,
  ) async => repository.getMessages(params.userId, params.otherUserId);
}
