import 'package:asra_ai/chat/chat.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    required this.chatId,
    required this.userId,
    required this.username,
    super.key,
  });

  final String chatId;
  final String userId;
  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(
        chatRepo: RepositoryProvider.of<ChatRepo>(context),
      )..loadMessages(chatId),
      child: MessagesView(
        chatId: chatId,
        userId: userId,
        username: username,
      ),
    );
  }
}
