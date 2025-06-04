import 'package:chat_firebase/feature/auth/auth_service.dart';
import 'package:chat_firebase/feature/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class UsersListWidget extends StatelessWidget {
  const UsersListWidget({super.key, required this.users});
  final List<Map<String, dynamic>> users;

  static final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: users.length,
      separatorBuilder:
          (context, index) => Container(height: 1, color: Colors.white),
      itemBuilder: (context, index) {
        final user = users[index];
        if (user['email'] == _authService.getCurrentUser().email) {
          return const SizedBox.shrink();
        }
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text(
              user['email'][0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(user['email']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ChatScreen(
                      senderId: _authService.getCurrentUser().uid,
                      receiverId: user['uid'],
                      receiverEmail: user['email'],
                    ),
              ),
            );
          },
        );
      },
    );
  }
}
