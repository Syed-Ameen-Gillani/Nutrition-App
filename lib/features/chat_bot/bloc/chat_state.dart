part of 'chat_bloc.dart';


sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<({Image? image, String? text, bool fromUser})> generatedContent;

  const ChatLoaded(this.generatedContent);

  @override
  List<Object> get props => [generatedContent];
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object> get props => [message];
}
