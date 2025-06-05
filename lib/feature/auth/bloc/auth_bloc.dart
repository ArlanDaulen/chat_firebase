import 'package:chat_firebase/core/utils/exceptions.dart';
import 'package:chat_firebase/domain/entities/user_entity.dart';
import 'package:chat_firebase/domain/usecases/auth_usecases/get_current_user_usecase.dart';
import 'package:chat_firebase/domain/usecases/auth_usecases/sign_in_usecase.dart';
import 'package:chat_firebase/domain/usecases/auth_usecases/sign_out_usecase.dart';
import 'package:chat_firebase/domain/usecases/auth_usecases/sign_up_usecase.dart';
import 'package:chat_firebase/domain/usecases/base_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(const AuthInitial()) {
    on<InitAuth>((event, emit) async {
      try {
        emit(const AuthLoading());
        final user = await getCurrentUserUseCase.call(NoParams());
        if (user != null) {
          emit(Authorized(user: user));
        } else {
          emit(const AuthInitial());
        }
      } catch (e) {
        _handleException(e, emit);
      }
    });

    on<SignIn>((event, emit) async {
      try {
        emit(const AuthLoading());
        final user = await signInUseCase.call(
          SignInUseCaseParams(email: event.email, password: event.password),
        );
        emit(Authorized(user: user));
      } catch (e) {
        _handleException(e, emit);
      }
    });

    on<SignUp>((event, emit) async {
      try {
        emit(const AuthLoading());
        final user = await signUpUseCase.call(
          SignUpUseCaseParams(email: event.email, password: event.password),
        );
        emit(Authorized(user: user));
      } catch (e) {
        _handleException(e, emit);
      }
    });

    on<SignOut>((event, emit) async {
      try {
        emit(const AuthLoading());
        await signOutUseCase.call(NoParams());
        emit(const AuthInitial());
      } catch (e) {
        _handleException(e, emit);
      }
    });
  }

  void _handleException(Object e, Emitter<AuthState> emit) {
    String message = e.toString();
    if (e is BaseException) {
      message = e.getMessage();
    }
    emit(AuthFailure(message: message));
  }
}
