import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:nutrovite/core/models/settings_model.dart';

class ThemeModeCubit extends Cubit<ThemeMode> {
  final Isar isar;

  ThemeModeCubit(this.isar) : super(ThemeMode.system) {
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    final settings = await isar.settings.get(1);
    final themeIndex = settings?.themeModeIndex ?? ThemeMode.system.index;
    emit(ThemeMode.values[themeIndex]);
  }

  void setThemeMode(ThemeMode themeMode) async {
    await isar.writeTxn(() async {
      final settings = await isar.settings.get(1);
      if (settings != null) {
        settings.themeModeIndex = themeMode.index;
        await isar.settings.put(settings);
      } else {
        final newSettings = Settings()
          ..id = 1
          ..themeModeIndex = themeMode.index
          ..geminiApiKey = null; // Default value
        await isar.settings.put(newSettings);
      }
    });
    emit(themeMode);
  }
}
