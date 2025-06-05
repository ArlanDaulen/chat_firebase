import 'package:chat_firebase/core/c_colors.dart';
import 'package:chat_firebase/core/injection/get_it_instance.dart';
import 'package:chat_firebase/domain/entities/message_entity.dart';
import 'package:chat_firebase/feature/chat/bloc/chat_bloc.dart';
import 'package:chat_firebase/feature/common/widgets/c_text_field.dart';
import 'package:chat_firebase/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final focusNode = FocusNode();
  final scrollController = ScrollController();
  final textController = TextEditingController();
  final chatBloc = getIt<ChatBloc>();

  @override
  void initState() {
    super.initState();
    chatBloc.add(
      GetMessages(userId: widget.senderId, otherUserId: widget.receiverId),
    );
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
    return BlocProvider<ChatBloc>.value(
      value: chatBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.receiverEmail ?? ''),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ).copyWith(bottom: 8),
          child: Column(
            children: [
              Expanded(
                child: _Chat(
                  chatBloc: chatBloc,
                  senderId: widget.senderId,
                  receiverId: widget.receiverId,
                  scrollController: scrollController,
                ),
              ),
              SizedBox(height: 8),
              _TextInput(
                chatBloc: chatBloc,
                receiverId: widget.receiverId,
                senderId: widget.senderId,
                focusNode: focusNode,
                controller: textController,
                onSend: scrollDown,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chat extends StatelessWidget {
  const _Chat({
    required this.chatBloc,
    required this.senderId,
    required this.receiverId,
    required this.scrollController,
  });
  final ChatBloc chatBloc;
  final String senderId;
  final String receiverId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Ошибка: ${state.message}')));
        }
      },
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ChatLoaded) {
          return _LoadedChat(
            messages: state.messages,
            senderId: senderId,
            scrollController: scrollController,
          );
        }
        return const Center(child: Text('Нет сообщений'));
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
  final List<MessageEntity> messages;
  final String? senderId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: messages.length,
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemBuilder: (context, index) {
        final message = messages[index];
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
                  message.message,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(width: 8),
                Text(
                  DateFormat.Hm().format(message.timestamp),
                  style: TextStyle(fontSize: 8, color: CColors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isSender(MessageEntity message) {
    return senderId == message.senderId;
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.chatBloc,
    required this.receiverId,
    required this.senderId,
    required this.focusNode,
    required this.controller,
    required this.onSend,
  });
  final ChatBloc chatBloc;
  final String receiverId;
  final String senderId;
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

  void _sendMessage(BuildContext context) {
    if (controller.text.isEmpty) return;
    chatBloc.add(
      SendMessage(
        message: MessageEntity(
          senderId: senderId,
          receiverId: receiverId,
          message: controller.text,
          timestamp: DateTime.now(),
        ),
      ),
    );
  }
}
