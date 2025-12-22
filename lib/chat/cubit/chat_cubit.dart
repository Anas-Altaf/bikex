import 'package:asra_ai/chat/chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required ChatRepo chatRepo,
  }) : _chatRepo = chatRepo,
       super(ChatInitial());

  final ChatRepo _chatRepo;

  // load messages for a chat
  void loadMessages(String chatId) async {
    emit(ChatLoading());
    try {
      final messages = await _chatRepo.getMessagesByChatId(chatId);
      emit(ChatLoaded(chatId: chatId, messages: messages));
    } on Exception catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  // send a message
  Future<void> sendMessage(String chatId, Message message) async {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;
      emit(ChatSending(messages: currentState.messages));
      try {
        await _chatRepo.sendMessage(chatId, message);
        final updatedMessages = List<Message>.from(currentState.messages)
          ..add(message);
        emit(ChatLoaded(chatId: chatId, messages: updatedMessages));
      } on Exception catch (e) {
        emit(ChatError(message: e.toString()));
      }
    }
  }

  // delete a message
  Future<void> deleteMessage(String chatId, String messageId) async {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;
      final updatedMessages = currentState.messages
          .where((message) => message.id != messageId)
          .toList();
      emit(ChatLoaded(chatId: chatId, messages: updatedMessages));
    }
  }
}
