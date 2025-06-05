import 'package:chat_firebase/domain/entities/message_entity.dart';
import 'package:chat_firebase/domain/repository/chat_repository.dart';
import 'package:chat_firebase/domain/usecases/base_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class SendMessageUseCaseParams extends Equatable {
  final MessageEntity message;
  const SendMessageUseCaseParams({required this.message});

  @override
  List<Object?> get props => [message];
}

@injectable
class SendMessageUseCase implements UseCase<void, SendMessageUseCaseParams> {
  final ChatRepository repository;
  SendMessageUseCase({required this.repository});

  @override
  Future<void> call(SendMessageUseCaseParams params) async {
    await repository.sendMessage(params.message);
  }
}
