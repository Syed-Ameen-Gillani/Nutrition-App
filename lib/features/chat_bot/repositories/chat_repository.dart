import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/services.dart';
import 'package:nutrovite/features/auth/models/user_model.dart';

class ChatRepository {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final String apiKey;
  final UserModel user;

  ChatRepository(this.apiKey, this.user) {
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
      systemInstruction: Content.text(
          "You are an AI Nutritionist. Your role is to provide advice related to nutrition, diet, and health. Try not to answer any questions that are not related to nutrition, diet, or health. If the user asks a question that is not related to nutrition, diet, or health, respond with \"I'm sorry, I'm not sure how to help with that.\" this is the UserModel for you to know about the person you are talking to ${user.toString()}. Always take with user with his/her name and suggest information according to his details."),
    );
    _chat = _model.startChat();
  }

  Future<String?> sendChatMessage(String message) async {
    try {
      final response = await _chat.sendMessage(Content.text(message));
      return response.text;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> sendImagePrompt(
    String message,
    List<String> imagePaths,
  ) async {
    try {
      List<ByteData> bytesData = [];

      for (var imagePath in imagePaths) {
        bytesData.add(await rootBundle.load(imagePath));
      }

      final content = [
        Content.multi([
          TextPart(message),
          for (var imagePath in bytesData)
            DataPart('image/jpeg', imagePath.buffer.asUint8List()),
        ])
      ];

      var response = await _model.generateContent(content);
      return response.text;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
