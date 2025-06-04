import 'package:chat_firebase/core/c_colors.dart';
import 'package:chat_firebase/feature/chat/chat_service.dart';
import 'package:chat_firebase/feature/common/widgets/c_text_field.dart';
import 'package:chat_firebase/gen/assets.gen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.senderId,
    required this.receiverId,
    required this.receiverEmail,
  });
  final String senderId;
  final String receiverId;
  final String? receiverEmail;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chat = ChatService();
  final focusNode = FocusNode();
  final scrollController = ScrollController();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 500)).whenComplete(scrollDown);
      }
    });
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    scrollController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail ?? ''),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: _Chat(
                chat: _chat,
                senderId: widget.senderId,
                receiverId: widget.receiverId,
                scrollController: scrollController,
              ),
            ),
            _TextInput(
              chat: _chat,
              receiverId: widget.receiverId,
              focusNode: focusNode,
              controller: textController,
              onSend: scrollDown,
            ),
          ],
        ),
      ),
    );
  }
}

class _Chat extends StatelessWidget {
  const _Chat({
    required this.chat,
    required this.senderId,
    required this.receiverId,
    required this.scrollController,
  });
  final ChatService chat;
  final String senderId;
  final String receiverId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chat.getMessages(senderId, receiverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Ошибка загрузки сообщений: ${snapshot.error}'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Нет сообщений'));
        }

        return _LoadedChat(
          messages: snapshot.data!.docs,
          senderId: senderId,
          scrollController: scrollController,
        );
      },
    );
  }
}

class _LoadedChat extends StatelessWidget {
  const _LoadedChat({
    required this.messages,
    required this.senderId,
    required this.scrollController,
  });
  final List<QueryDocumentSnapshot<Object?>> messages;
  final String? senderId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: messages.length,
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemBuilder: (context, index) {
        final message = messages[index].data() as Map<String, dynamic>;
        return Align(
          alignment:
              isSender(message) ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CColors.analog2,
              borderRadius: BorderRadius.circular(16).copyWith(
                bottomLeft:
                    isSender(message) ? Radius.circular(16) : Radius.zero,
                bottomRight:
                    isSender(message) ? Radius.zero : Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message['message'] ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(width: 8),
                Text(
                  DateFormat.Hm().format(DateTime.parse(message['timestamp'])),
                  style: TextStyle(fontSize: 8, color: CColors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isSender(Map<String, dynamic> message) {
    return senderId == message['sender_id'];
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.chat,
    required this.receiverId,
    required this.focusNode,
    required this.controller,
    required this.onSend,
  });
  final ChatService chat;
  final String receiverId;
  final FocusNode focusNode;
  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CTextField(
            controller: controller,
            hintText: 'Введите сообщение',
            isDense: true,
            focusNode: focusNode,
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () => _sendMessage(context),
          child: Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CColors.analog2,
            ),
            child: CAssets.icons.send.svg(),
          ),
        ),
      ],
    );
  }

  void _sendMessage(BuildContext context) async {
    if (controller.text.isEmpty) return;
    try {
      await chat.sendMessage(
        receiverId: receiverId,
        message: controller.text.trim(),
      );
      controller.clear();
      onSend();
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(content: Text('Ошибка отправки: $e')),
      );
    }
  }
}
