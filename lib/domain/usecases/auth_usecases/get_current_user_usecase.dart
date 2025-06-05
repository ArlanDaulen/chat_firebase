import 'package:chat_firebase/domain/entities/user_entity.dart';
import 'package:chat_firebase/domain/repository/auth_repository.dart';
import 'package:chat_firebase/domain/usecases/base_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentUserUseCase extends UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;
  GetCurrentUserUseCase({required this.repository});

  @override
  Future<UserEntity?> call(NoParams params) async =>
      await repository.getCurrentUser();
}
