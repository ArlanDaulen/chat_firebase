import 'package:chat_firebase/domain/entities/user_entity.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? fcmToken;

  const UserModel({this.id, this.email, this.fcmToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['uid'] as String?,
      email: json['email'] as String?,
      fcmToken: json['fcm_token'] as String?,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      fcmToken: entity.fcmToken,
    );
  }

  UserEntity toEntity() {
    return UserEntity(id: id ?? '', email: email ?? '', fcmToken: fcmToken);
  }

  Map<String, dynamic> toJson() {
    return {'uid': id, 'email': email, 'fcm_token': fcmToken};
  }
}
