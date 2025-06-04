import 'package:chat_firebase/domain/entities/user_entity.dart';

class UserModel {
  final String? id;
  final String? email;

  const UserModel({this.id, this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['uid'] as String?,
      email: json['email'] as String?,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(id: entity.id, email: entity.email);
  }

  UserEntity toEntity() {
    return UserEntity(id: id ?? '', email: email ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'uid': id, 'email': email};
  }
}
