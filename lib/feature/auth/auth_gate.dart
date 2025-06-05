import 'package:chat_firebase/core/injection/get_it_instance.dart';
import 'package:chat_firebase/feature/auth/auth_screen.dart';
import 'package:chat_firebase/feature/auth/bloc/auth_bloc.dart';
import 'package:chat_firebase/feature/main/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>.value(
      value: getIt<AuthBloc>()..add(const InitAuth()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ошибка авторизации: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is Authorized) {
            return HomeScreen(currentUser: state.user);
          }
          return AuthScreen();
        },
      ),
    );
  }
}
