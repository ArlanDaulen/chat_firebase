import 'package:chat_firebase/data/datasource/auth_remote_datasource.dart';
import 'package:chat_firebase/domain/entities/user_entity.dart';
import 'package:chat_firebase/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> signIn(String email, password) async {
    final user = await remoteDataSource.signIn(email, password);
    return user.toEntity();
  }

  @override
  Future<UserEntity> signUp(String email, password) async {
    final user = await remoteDataSource.signUp(email, password);
    return user.toEntity();
  }

  @override
  Future<void> signOut() async => await remoteDataSource.signOut();

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = await remoteDataSource.getCurrentUser();
    if (user == null) return null;
    return user.toEntity();
  }
}
