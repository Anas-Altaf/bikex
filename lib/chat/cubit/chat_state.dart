import 'package:asra_ai/chat/chat.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class ChatInitial extends ChatState {}

// Loading state
class ChatLoading extends ChatState {
  ChatLoading();
}

// Loaded state
class ChatLoaded extends ChatState {
  ChatLoaded({required this.chatId, required this.messages});

  final String chatId;
  final List<Message> messages;

  @override
  List<Object?> get props => [chatId, messages];
}

// Error state
class ChatError extends ChatState {
  ChatError({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

// Chat Sending state, with keeping existing messages
class ChatSending extends ChatState {
  ChatSending({required this.messages});
  final List<Message> messages;

  @override
  List<Object?> get props => [messages];
}
