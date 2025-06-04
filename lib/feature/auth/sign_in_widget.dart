import 'package:chat_firebase/feature/auth/auth_service.dart';
import 'package:chat_firebase/feature/common/widgets/c_text_field.dart';
import 'package:flutter/material.dart';

class SignInWidet extends StatelessWidget {
  const SignInWidet({super.key});

  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();

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
          ElevatedButton(
            onPressed: () => _signIn(context),
            child: Text('Войти'),
          ),
        ],
      ),
    );
  }

  void _signIn(BuildContext context) async {
    try {
      final auth = AuthService();
      await auth.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder:
            (context) => AlertDialog(content: Text('Ошибка авторизации: $e')),
      );
    }
  }
}
