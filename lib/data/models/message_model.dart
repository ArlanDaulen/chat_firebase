import 'package:chat_firebase/domain/entities/message_entity.dart';

class MessageModel {
  final String? senderId;
  final String? receiverId;
  final String? message;
  final String? timestamp;

  const MessageModel({
    this.senderId,
    this.receiverId,
    this.message,
    this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    senderId: json['sender_id'] as String?,
    receiverId: json['receiver_id'] as String?,
    message: json['message'] as String?,
    timestamp: json['timestamp'] as String?,
  );

  factory MessageModel.fromEntity(MessageEntity entity) => MessageModel(
    senderId: entity.senderId,
    receiverId: entity.receiverId,
    message: entity.message,
    timestamp: entity.timestamp.toString(),
  );

  MessageEntity toEntity() {
    return MessageEntity(
      senderId: senderId ?? '',
      receiverId: receiverId ?? '',
      message: message ?? '',
      timestamp: DateTime.parse(timestamp ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
