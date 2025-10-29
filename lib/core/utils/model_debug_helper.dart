import 'dart:developer';
import 'package:nutrovite/features/chat_bot/repositories/chat_repository.dart';
import 'package:nutrovite/features/home/models/constants.dart';

/// Debug utility class for testing Gemini models
// class ModelDebugHelper {

//   /// Quick function to list all available models during development
//   /// Test if current model in ChatRepository is available
//   static Future<void> debugCurrentModel() async {
//     try {
//       log('🔍 DEBUG: Testing current model availability...');
//       const currentModel = 'gemini-1.5-flash-latest';
      
//       final works = await ChatRepository.testModel(ServerConstants.apiKey, currentModel);
      
//       if (works) {
//         log('✅ DEBUG: Current model "$currentModel" is working perfectly!');
//       } else {
//         log('❌ DEBUG: Current model "$currentModel" is NOT working!');
//         log('💡 Testing alternatives...');
        
//         // final workingModels = await ChatRepository.getWorkingModels(ServerConstants.apiKey);
//         if (workingModels.isNotEmpty) {
//           log('💡 Working alternatives:');
//           for (final model in workingModels.take(3)) {
//             log('   - $model');
//           }
//         } else {
//           log('❌ No working models found!');
//         }
//       }
//     } catch (e) {
//       log('❌ DEBUG: Error testing current model: $e');
//     }
//   }
// }
