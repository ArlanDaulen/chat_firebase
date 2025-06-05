import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;

  const MessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  MessageEntity copyWith({
    String? senderId,
    String? receiverId,
    String? message,
    DateTime? timestamp,
  }) {
    return MessageEntity(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [senderId, receiverId, message, timestamp];
}
