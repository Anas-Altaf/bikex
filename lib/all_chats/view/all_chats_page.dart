import 'package:asra_ai/chat/repo/chat_repo.dart';
import 'package:asra_ai/chat/view/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllChatsPage extends StatelessWidget {
  const AllChatsPage({
    required this.userId,
    required this.username,
    super.key,
  });

  final String userId;
  final String username;

  @override
  Widget build(BuildContext context) {
    final chatRepo = context.read<ChatRepo>();
    final chats = chatRepo.getAllChats();

    return Scaffold(
      appBar: AppBar(
        title: Text('Chats - $username'),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          final lastMessage = chat.messages.isNotEmpty
              ? chat.messages.last.text
              : 'No messages yet';

          return ListTile(
            leading: CircleAvatar(
              child: Text(chat.title[0].toUpperCase()),
            ),
            title: Text(chat.title),
            subtitle: Text(
              lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: chat.messages.isNotEmpty
                ? Text(
                    '${chat.messages.length}',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                : null,
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ChatPage(
                    chatId: chat.id,
                    userId: userId,
                    username: username,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateChatDialog(context, chatRepo),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showCreateChatDialog(
    BuildContext context,
    ChatRepo chatRepo,
  ) async {
    final controller = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Create New Chat'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Chat Title',
            hintText: 'Enter chat title',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.trim().isEmpty) return;

              await chatRepo.createChat(controller.text.trim());

              if (dialogContext.mounted) {
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
