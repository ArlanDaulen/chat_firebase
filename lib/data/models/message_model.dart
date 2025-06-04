import 'package:chat_firebase/domain/entities/message_entity.dart';

class MessageModel {
  final String? senderId;
  final String? senderEmail;
  final String? receiverId;
  final String? message;
  final String? timestamp;

  const MessageModel({
    this.senderId,
    this.senderEmail,
    this.receiverId,
    this.message,
    this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    senderId: json['senderId'] as String?,
    senderEmail: json['senderEmail'] as String?,
    receiverId: json['receiverId'] as String?,
    message: json['message'] as String?,
    timestamp: json['timestamp'] as String?,
  );

  factory MessageModel.fromEntity(MessageEntity entity) => MessageModel(
    senderId: entity.senderId,
    senderEmail: entity.senderEmail,
    receiverId: entity.receiverId,
    message: entity.message,
    timestamp: entity.timestamp.toString(),
  );

  MessageEntity toEntity() {
    return MessageEntity(
      senderId: senderId ?? '',
      senderEmail: senderEmail ?? '',
      receiverId: receiverId ?? '',
      message: message ?? '',
      timestamp: DateTime.parse(timestamp ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'sender_email': senderEmail,
      'receiver_id': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
