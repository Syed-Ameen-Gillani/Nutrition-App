import 'package:isar/isar.dart';

part 'chat_model.g.dart';

@collection
class ChatMessage {
  Id id = Isar.autoIncrement;
  final String? text;
  final String? imagePath;
  final bool fromUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.imagePath,
    required this.fromUser,
    required this.timestamp,
  });
}
