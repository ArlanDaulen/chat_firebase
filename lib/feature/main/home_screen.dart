import 'package:chat_firebase/core/injection/get_it_instance.dart';
import 'package:chat_firebase/domain/entities/user_entity.dart';
import 'package:chat_firebase/feature/auth/bloc/auth_bloc.dart';
import 'package:chat_firebase/feature/main/bloc/home_bloc.dart';
import 'package:chat_firebase/feature/main/users_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.currentUser});
  final UserEntity currentUser;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeBloc = getIt<HomeBloc>()..add(const LoadUsers());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>.value(
      value: homeBloc,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => getIt<AuthBloc>().add(const SignOut()),
          child: Icon(Icons.logout),
        ),
        appBar: AppBar(title: const Text('Home Screen'), centerTitle: true),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeFailure) {
              return Center(child: Text('Ошибка: ${state.message}'));
            }
            if (state is HomeLoaded) {
              return UsersListWidget(
                users: state.users,
                currentUser: widget.currentUser,
              );
            }
            return const Center(child: Text('Нет пользователей'));
          },
        ),
      ),
    );
  }
}
