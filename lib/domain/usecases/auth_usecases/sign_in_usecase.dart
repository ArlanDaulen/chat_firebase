import 'package:chat_firebase/domain/entities/user_entity.dart';
import 'package:chat_firebase/domain/repository/auth_repository.dart';
import 'package:chat_firebase/domain/usecases/base_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class SignInUseCaseParams extends Equatable {
  final String email;
  final String password;

  const SignInUseCaseParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

@injectable
class SignInUseCase implements UseCase<UserEntity, SignInUseCaseParams> {
  final AuthRepository repository;
  SignInUseCase({required this.repository});

  @override
  Future<UserEntity> call(SignInUseCaseParams params) async =>
      await repository.signIn(params.email, params.password);
}
