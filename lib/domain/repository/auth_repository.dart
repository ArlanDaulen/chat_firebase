import 'package:chat_firebase/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(String email, password);
  Future<UserEntity> signUp(String email, password);
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
}
