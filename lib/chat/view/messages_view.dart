import 'package:asra_ai/chat/chat.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({
    required this.chatId,
    required this.userId,
    required this.username,
    super.key,
  });

  final String chatId;
  final String userId;
  final String username;

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final message = Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      userId: widget.userId,
      timestamp: DateTime.now(),
    );

    await context.read<ChatCubit>().sendMessage(widget.chatId, message);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat - ${widget.username}'),
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ChatError) {
                  return Center(
                    child: Text('Error: ${state.message}'),
                  );
                }

                if (state is ChatLoaded) {
                  if (state.messages.isEmpty) {
                    return const Center(
                      child: Text('No messages yet. Start the conversation!'),
                    );
                  }

                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages.reversed.toList()[index];
                      final isMe = message.userId == widget.userId;

                      return MessageBubble(
                        message: message,
                        isMe: isMe,
                      );
                    },
                  );
                }

                if (state is ChatSending) {
                  // Show messages while sending
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages.reversed.toList()[index];
                      final isMe = message.userId == widget.userId;

                      return MessageBubble(
                        message: message,
                        isMe: isMe,
                      );
                    },
                  );
                }

                return const Center(
                  child: Text('Start chatting!'),
                );
              },
            ),
          ),

          // Input field
          ChatInput(
            controller: _messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}
