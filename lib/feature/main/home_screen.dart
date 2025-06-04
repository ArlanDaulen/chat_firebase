import 'package:chat_firebase/feature/auth/auth_service.dart';
import 'package:chat_firebase/feature/chat/chat_service.dart';
import 'package:chat_firebase/feature/main/users_list_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _logOut(context),
        child: Icon(Icons.logout),
      ),
      appBar: AppBar(title: const Text('Home Screen'), centerTitle: true),
      body: StreamBuilder(
        stream: _chatService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ошибка загрузки пользователей: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет пользователей'));
          }
          return UsersListWidget(users: snapshot.data!);
        },
      ),
    );
  }

  void _logOut(BuildContext context) async {
    try {
      final auth = AuthService();

      await auth.signOut();
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(content: Text('Ошибка выхода: $e')),
      );
    }
  }
}
