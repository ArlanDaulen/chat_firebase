part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class InitAuth extends AuthEvent {
  const InitAuth();
}

class SignIn extends AuthEvent {
  const SignIn({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignUp extends AuthEvent {
  const SignUp({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthEvent {
  const SignOut();
}
