import 'package:chat_firebase/core/utils/bloc_extension.dart';
import 'package:chat_firebase/core/utils/exceptions.dart';
import 'package:chat_firebase/domain/entities/message_entity.dart';
import 'package:chat_firebase/domain/usecases/chat_usecases/get_messages_usecase.dart';
import 'package:chat_firebase/domain/usecases/chat_usecases/send_message_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;

  ChatBloc({required this.getMessagesUseCase, required this.sendMessageUseCase})
    : super(const ChatInitial()) {
    on<GetMessages>((event, emit) async {
      try {
        emit(const ChatLoading());
        final messages = await getMessagesUseCase.call(
          GetMessagesUseCaseParams(
            userId: event.userId,
            otherUserId: event.otherUserId,
          ),
        );
        return await emit.forEach(
          messages,
          onData: (messagesList) => ChatLoaded(messages: messagesList),
        );
      } catch (e) {
        _handleException(e, emit);
      }
    });

    on<SendMessage>((event, emit) async {
      try {
        await sendMessageUseCase.call(
          SendMessageUseCaseParams(message: event.message),
        );
      } catch (e) {
        _handleException(e, emit, shouldEmitOnce: true);
      }
    });
  }

  void _handleException(
    Object e,
    Emitter<ChatState> emit, {
    bool shouldEmitOnce = false,
  }) {
    String message = e.toString();
    if (e is BaseException) {
      message = e.getMessage();
    }
    if (shouldEmitOnce) {
      emitOneShot(ChatFailure(message: message));
      return;
    }
    emit(ChatFailure(message: message));
  }
}
