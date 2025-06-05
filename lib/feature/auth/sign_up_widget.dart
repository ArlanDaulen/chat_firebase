import 'package:chat_firebase/core/injection/get_it_instance.dart';
import 'package:chat_firebase/feature/auth/bloc/auth_bloc.dart';
import 'package:chat_firebase/feature/common/widgets/c_text_field.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();
  static final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CTextField(controller: _emailController, hintText: 'Email'),
          const SizedBox(height: 16),
          CTextField(
            controller: _passwordController,
            hintText: 'Пароль',
            obscureText: true,
          ),
          const SizedBox(height: 16),
          CTextField(
            controller: _confirmPasswordController,
            hintText: 'Повторите пароль',
            obscureText: true,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _signUp(context),
            child: Text('Зарегистрироваться'),
          ),
        ],
      ),
    );
  }

  void _signUp(BuildContext context) {
    if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(content: Text('Пароли не совпадают!')),
      );
      return;
    }
    getIt<AuthBloc>().add(
      SignUp(email: _emailController.text, password: _passwordController.text),
    );
  }
}
