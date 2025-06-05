import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? fcmToken;

  const UserEntity({required this.id, required this.email, this.fcmToken});

  @override
  List<Object?> get props => [id, email, fcmToken];
}
