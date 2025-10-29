import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrovite/features/chat_bot/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repository;

  ChatBloc(this._repository) : super(ChatInitial()) {
    on<SendChatMessage>(_onSendChatMessage);
    // on<SendImagePrompt>(_onSendImagePrompt);
  }

  Future<void> _onSendChatMessage(
    SendChatMessage event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    try {
      final response = await _repository.sendChatMessage(event.message);
      final currentContent = (state as ChatLoaded).generatedContent;
      final newContent = [
        ...currentContent,
        (image: null, text: event.message, fromUser: true),
        (image: null, text: response, fromUser: false),
      ];
      emit(ChatLoaded(newContent));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  // Future<void> _onSendImagePrompt(SendImagePrompt event, Emitter<ChatState> emit) async {
  //   emit(ChatLoading());
  //   try {
  //     final response = await _repository.sendImagePrompt(event.message);
  //     final currentContent = (state as ChatLoaded).generatedContent;
  //     final newContent = [
  //       ...currentContent,
  //       (image: Image.asset("assets/images/cat.jpg"), text: event.message, fromUser: true),
  //       (image: Image.asset("assets/images/scones.jpg"), text: null, fromUser: true),
  //       (image: null, text: response, fromUser: false),
  //     ];
  //     emit(ChatLoaded(newContent));
  //   } catch (e) {
  //     emit(ChatError(e.toString()));
  //   }
  // }
}
