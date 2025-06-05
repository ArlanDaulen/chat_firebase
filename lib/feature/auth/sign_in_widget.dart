import 'package:chat_firebase/core/injection/get_it_instance.dart';
import 'package:chat_firebase/core/utils/c_validator.dart';
import 'package:chat_firebase/feature/auth/bloc/auth_bloc.dart';
import 'package:chat_firebase/feature/common/widgets/c_text_field.dart';
import 'package:flutter/material.dart';

class SignInWidet extends StatelessWidget {
  const SignInWidet({super.key});

  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CTextField(
              controller: _emailController,
              hintText: 'Email',
              validator: CValidator.validateEmail,
            ),
            const SizedBox(height: 16),
            CTextField(
              controller: _passwordController,
              validator: CValidator.validatePassword,
              hintText: 'Пароль',
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: signIn, child: Text('Войти')),
          ],
        ),
      ),
    );
  }

  void signIn() {
    if (_formKey.currentState?.validate() ?? false) {
      getIt<AuthBloc>().add(
        SignIn(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }
}
