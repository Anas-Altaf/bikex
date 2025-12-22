import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.text,
    required this.userId,
    required this.timestamp,
  });

  final String id;
  final String text;
  final String userId;
  final DateTime timestamp;

  Message copyWith({
    String? id,
    String? text,
    String? userId,
    String? receiverId,
    DateTime? timestamp,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [id, text, userId, timestamp];
  // to string
  @override
  String toString() {
    return 'Message{id: $id, text: $text, userId: $userId, timestamp: $timestamp}';
  }
}
