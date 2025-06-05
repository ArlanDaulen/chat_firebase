part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatLoaded extends ChatState {
  const ChatLoaded({required this.messages});
  final List<MessageEntity> messages;

  @override
  List<Object?> get props => [messages];
}

class ChatFailure extends ChatState {
  const ChatFailure({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
