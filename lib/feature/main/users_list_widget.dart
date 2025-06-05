import 'package:chat_firebase/domain/entities/user_entity.dart';
import 'package:chat_firebase/feature/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class UsersListWidget extends StatelessWidget {
  const UsersListWidget({
    super.key,
    required this.users,
    required this.currentUser,
  });
  final List<UserEntity> users;
  final UserEntity currentUser;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: users.length,
      separatorBuilder:
          (context, index) => Container(height: 1, color: Colors.white),
      itemBuilder: (context, index) {
        final user = users[index];
        if (user.email == currentUser.email) {
          return const SizedBox.shrink();
        }
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text(
              user.email[0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(user.email),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ChatScreen(
                      senderId: currentUser.id,
                      receiverId: user.id,
                      receiverEmail: user.email,
                    ),
              ),
            );
          },
        );
      },
    );
  }
}
