part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  const HomeLoaded({required this.users});
  final List<UserEntity> users;

  @override
  List<Object> get props => [users];
}

class HomeFailure extends HomeState {
  const HomeFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
