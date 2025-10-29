import 'package:isar/isar.dart';

part 'settings_model.g.dart'; // Required for code generation

@collection
class Settings {
  Id id = 1;
  @Index(unique: true)
  late String? geminiApiKey;
  late int themeModeIndex;
}
