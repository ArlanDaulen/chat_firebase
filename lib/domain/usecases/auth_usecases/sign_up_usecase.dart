import 'package:chat_firebase/domain/entities/user_entity.dart';
import 'package:chat_firebase/domain/repository/auth_repository.dart';
import 'package:chat_firebase/domain/usecases/base_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class SignUpUseCaseParams extends Equatable {
  final String email;
  final String password;

  const SignUpUseCaseParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

@injectable
class SignUpUseCase implements UseCase<UserEntity, SignUpUseCaseParams> {
  final AuthRepository repository;
  SignUpUseCase({required this.repository});

  @override
  Future<UserEntity> call(SignUpUseCaseParams params) async =>
      await repository.signUp(params.email, params.password);
}
