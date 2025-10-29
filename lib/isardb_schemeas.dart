import 'package:isar/isar.dart';
import 'package:nutrovite/core/models/settings_model.dart';
import 'package:nutrovite/features/auth/models/user_model.dart';
import 'package:nutrovite/features/home/models/member_source.dart';
import 'package:nutrovite/features/home/models/nutrition_intake.dart';
import 'package:nutrovite/features/source_api/source_neutrant.dart';
import 'features/chat_bot/models/chat_model.dart';

final List<CollectionSchema> isarDbSchemeas = [
  UserModelSchema,
  ChatMessageSchema,
  SettingsSchema,
  SourceNeutrantSchema,
  NutritionIntakesSchema,
  SourceSelectionSchema
];
