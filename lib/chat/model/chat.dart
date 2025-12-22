import 'package:asra_ai/chat/model/message.dart';

class Chat {
  const Chat({
    required this.id,
    required this.title,
    required this.messages,
  });

  final String id;
  final String title;
  final List<Message> messages;

  Chat copyWith({
    String? id,
    String? title,
    List<Message>? messages,
  }) {
    return Chat(
      id: id ?? this.id,
      title: title ?? this.title,
      messages: messages ?? this.messages,
    );
  }
}
