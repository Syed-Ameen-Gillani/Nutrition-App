part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendChatMessage extends ChatEvent {
  final String message;

  const SendChatMessage(this.message);

  @override
  List<Object> get props => [message];
}

class SendImagePrompt extends ChatEvent {
  final List<String> message;

  const SendImagePrompt(this.message);

  @override
  List<Object> get props => [message];
}
