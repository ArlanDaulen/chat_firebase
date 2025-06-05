part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class GetMessages extends ChatEvent {
  const GetMessages({required this.userId, required this.otherUserId});
  final String userId;
  final String otherUserId;

  @override
  List<Object?> get props => [userId, otherUserId];
}

class SendMessage extends ChatEvent {
  const SendMessage({required this.message});
  final MessageEntity message;

  @override
  List<Object?> get props => [message];
}
