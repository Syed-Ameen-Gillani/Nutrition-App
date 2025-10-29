import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:nutrovite/core/models/settings_model.dart';

class GeminiApiCubit extends Cubit<String?> {
  final Isar isar;

  GeminiApiCubit(this.isar) : super('AIzaSyBFIzUPjJFMuDwiza5ziTtT3Gzy_vj0-_Q') {
    _loadGeminiApiKey();
  }

  void _loadGeminiApiKey() async {
    try {
      final settings = await isar.settings.get(1);
      final geminiApiKey = settings?.geminiApiKey;
      log('Loaded Gemini API Key: $geminiApiKey'); // Debug statement
      emit(geminiApiKey);
    } catch (e) {
      log('Error loading API key: $e'); // Debug statement
    }
  }

  void setGeminiApiKey(String geminiApiKey) async {
    try {
      await isar.writeTxn(() async {
        final settings = await isar.settings.get(1);
        if (settings != null) {
          settings.geminiApiKey = geminiApiKey;
          await isar.settings.put(settings);
        } else {
          final newSettings = Settings()
            ..id = 1
            ..geminiApiKey = geminiApiKey
            ..themeModeIndex = ThemeMode.system.index;
          await isar.settings.put(newSettings);
        }
      });
      log('Set Gemini API Key: $geminiApiKey'); // Debug statement
      emit(geminiApiKey);
    } catch (e) {
      log('Error setting API key: $e'); // Debug statement
    }
  }

  void clearGeminiApiKey() async {
    try {
      await isar.writeTxn(() async {
        final settings = await isar.settings.get(1);
        if (settings != null) {
          settings.geminiApiKey = null;
          await isar.settings.put(settings);
        }
      });
      log('Cleared Gemini API Key'); // Debug statement
      emit(null);
    } catch (e) {
      log('Error clearing API key: $e'); // Debug statement
    }
  }
}
