import 'dart:async';
import 'package:asra_ai/chat/model/chat.dart';
import 'package:asra_ai/chat/model/message.dart';

class ChatRepo {
  ChatRepo() {
    _initializeMockData();
  }
  // In-memory storage
  final Map<String, Chat> _chats = {};

  // Stream controllers
  final _chatsController = StreamController<List<Chat>>.broadcast();
  final Map<String, StreamController<List<Message>>> _messageControllers = {};

  void _initializeMockData() {
    // Create mock chats
    _chats['1'] = Chat(
      id: '1',
      title: 'General Chat',
      messages: [
        Message(
          id: 'm1',
          text: 'Hello everyone!',
          userId: 'user1',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        Message(
          id: 'm2',
          text: 'Hi there!',
          userId: 'user2',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        Message(
          id: 'm3',
          text: 'How are you all?',
          userId: 'user1',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
      ],
    );

    _chats['2'] = Chat(
      id: '2',
      title: 'Flutter Devs',
      messages: [
        Message(
          id: 'm4',
          text: 'BLoC is awesome!',
          userId: 'user3',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Message(
          id: 'm5',
          text: 'I totally agree!',
          userId: 'user1',
          timestamp: DateTime.now().subtract(const Duration(hours: 12)),
        ),
      ],
    );

    _chats['3'] = const Chat(
      id: '3',
      title: 'Random',
      messages: [],
    );
  }

  /// Get all chats as a stream
  Stream<List<Chat>> getChatsStream() {
    // Emit initial data
    _chatsController.add(_chats.values.toList());
    return _chatsController.stream;
  }

  /// Get all chats (sync)
  List<Chat> getAllChats() {
    return _chats.values.toList();
  }

  /// Get messages stream for a specific chat
  Stream<List<Message>> getMessagesStream(String chatId) {
    // Create controller if doesn't exist
    if (!_messageControllers.containsKey(chatId)) {
      _messageControllers[chatId] = StreamController<List<Message>>.broadcast();
    }

    // Emit initial data
    final chat = _chats[chatId];
    if (chat != null) {
      _messageControllers[chatId]!.add(List.from(chat.messages));
    }

    return _messageControllers[chatId]!.stream;
  }

  /// Get messages by chat id (async)
  Future<List<Message>> getMessagesByChatId(String chatId) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final chat = _chats[chatId];
    if (chat == null) {
      return [];
    }
    return List.from(chat.messages);
  }

  /// Send a message
  Future<void> sendMessage(String chatId, Message message) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final chat = _chats[chatId];
    if (chat != null) {
      // Add message to chat
      final updatedMessages = List<Message>.from(chat.messages)..add(message);
      _chats[chatId] = chat.copyWith(messages: updatedMessages);

      // Notify listeners via stream
      if (_messageControllers.containsKey(chatId)) {
        _messageControllers[chatId]!.add(updatedMessages);
      }

      // Update chats list
      _chatsController.add(_chats.values.toList());
    }
  }

  /// Delete a message
  Future<void> deleteMessage(String chatId, String messageId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final chat = _chats[chatId];
    if (chat != null) {
      final updatedMessages = chat.messages
          .where((message) => message.id != messageId)
          .toList();

      _chats[chatId] = chat.copyWith(messages: updatedMessages);

      // Notify listeners
      if (_messageControllers.containsKey(chatId)) {
        _messageControllers[chatId]!.add(updatedMessages);
      }

      _chatsController.add(_chats.values.toList());
    }
  }

  /// Create a new chat
  Future<String> createChat(String title) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final chatId = 'chat_${DateTime.now().millisecondsSinceEpoch}';
    _chats[chatId] = Chat(
      id: chatId,
      title: title,
      messages: [],
    );

    _chatsController.add(_chats.values.toList());
    return chatId;
  }

  Future<void> dispose() async {
    await _chatsController.close();
    for (final controller in _messageControllers.values) {
      await controller.close();
    }
  }
}
