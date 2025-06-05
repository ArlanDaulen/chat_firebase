import 'package:chat_firebase/core/injection/get_it_instance.dart';
import 'package:chat_firebase/feature/auth/bloc/auth_bloc.dart';
import 'package:chat_firebase/feature/auth/sign_in_widget.dart';
import 'package:chat_firebase/feature/auth/sign_up_widget.dart';
import 'package:chat_firebase/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _tabs = {
    'Войти': const SignInWidet(),
    'Зарегистрироваться': const SignUpWidget(),
  };

  final authBloc = getIt<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 40),
              CAssets.general.discord.svg(width: 100, height: 100),
              TabBar(
                tabs: _tabs.entries.map((e) => Tab(text: e.key)).toList(),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerHeight: 0,
              ),
              const SizedBox(height: 16),
              Flexible(child: TabBarView(children: _tabs.values.toList())),
            ],
          ),
        ),
      ),
    );
  }
}
