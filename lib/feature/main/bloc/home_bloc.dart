import 'package:chat_firebase/core/utils/exceptions.dart';
import 'package:chat_firebase/domain/entities/user_entity.dart';
import 'package:chat_firebase/domain/usecases/base_usecase.dart';
import 'package:chat_firebase/domain/usecases/chat_usecases/get_users_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@singleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsersUseCase getUsersUseCase;

  HomeBloc({required this.getUsersUseCase}) : super(HomeInitial()) {
    on<LoadUsers>((event, emit) async {
      try {
        emit(const HomeLoading());
        final users = await getUsersUseCase.call(NoParams());
        return await emit.forEach(
          users,
          onData: (usersList) => HomeLoaded(users: usersList),
        );
      } on BaseException catch (e) {
        emit(HomeFailure(message: e.getMessage()));
      } catch (e) {
        emit(HomeFailure(message: e.toString()));
      }
    });
  }
}
