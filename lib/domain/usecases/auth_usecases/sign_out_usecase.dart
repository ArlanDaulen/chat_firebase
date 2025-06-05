import 'package:chat_firebase/domain/repository/auth_repository.dart';
import 'package:chat_firebase/domain/usecases/base_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignOutUseCase extends UseCase<void, NoParams> {
  final AuthRepository repository;
  SignOutUseCase({required this.repository});

  @override
  Future<void> call(NoParams params) async => await repository.signOut();
}
