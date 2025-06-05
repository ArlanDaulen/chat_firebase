import 'package:chat_firebase/domain/entities/user_entity.dart';
import 'package:chat_firebase/domain/repository/chat_repository.dart';
import 'package:chat_firebase/domain/usecases/base_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUsersUseCase implements UseCase<Stream<List<UserEntity>>, NoParams> {
  final ChatRepository repository;
  GetUsersUseCase({required this.repository});

  @override
  Future<Stream<List<UserEntity>>> call(NoParams params) async =>
      repository.getUsers();
}
