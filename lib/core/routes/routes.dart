import 'package:flutter/material.dart';
import 'package:nutrovite/core/image_viewer.dart';
import 'package:nutrovite/features/auth/views/screens/login_screen.dart';
import 'package:nutrovite/features/auth/views/screens/signup_screen.dart';
import 'package:nutrovite/features/chat_bot/views/chat_screen.dart';
import 'package:nutrovite/features/home/models/family.dart';
import 'package:nutrovite/features/home/views/colors.dart';
import 'package:nutrovite/features/home/views/dashboard.dart';
import 'package:nutrovite/features/home/views/family_member_dashboard.dart';
import 'package:nutrovite/features/home/views/family_screen.dart';
import 'package:nutrovite/features/home/views/home_screen.dart';
import 'package:nutrovite/features/home/views/main_screen.dart';
import 'package:nutrovite/features/home/views/neutrant_screen.dart';
import 'package:nutrovite/features/home/views/nutrients_sources.dart';
import 'package:nutrovite/features/home/views/nutrition_intake_info.dart';
import 'package:nutrovite/features/home/views/price_screen.dart';
import 'package:nutrovite/features/recipes_api_for_food/food_api_screen.dart';
import 'package:nutrovite/features/settings/views/add_family.dart';
import 'package:nutrovite/features/settings/views/apperances.dart';
import 'package:nutrovite/features/settings/views/gemini_api_screen.dart';
import 'package:nutrovite/features/settings/views/profile_screen.dart';
import 'package:nutrovite/features/settings/views/settings_screen.dart';
import 'package:nutrovite/features/source_api/source_screen.dart';

// Map<String, Widget Function(BuildContext)> routes = {
//   '/otp': (context) => const OtpScreen(),
//   '/signin': (context) => const SignInScreen(),
//   '/signup': (context) => const SignUpScreen(),
//   '/home': (context) => const HomeScreen(),
//   '/chat': (context) => const ChatScreen(),
//   '/testapi': (context) => const TestApi(),
//   '/dashboard': (context) => const Dashboard(),
//   '/sources': (context) => const NutrientsSourcesScreen(),
//   '/nutrient': (context) => const NutrientScreen(),
//   // '/sources': (context) => const NutrientSources(),
//   '/intakeInfo': (context) => const NutritionIntakeInfo(),
//   '/colors': (context) => ColorPreviewScreen(),
//   '/profile': (context) => const ProfileScreen(),
//   '/settings': (context) => const SettingsScreen(),
//   '/family': (context) => FamilyNutritionScreen(),
//   '/prices': (context) => const PriceListScreen(),
//   '/family/add': (context) => AddFamilyMemberScreen(),
//   '/preview': (context) => FullScreenImage(imageFile: context., ),
// };

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case '/otp':
    //   return MaterialPageRoute(builder: (context) => const OtpScreen());

    case '/signin':
      return MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      );

    case '/signup':
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );

    case '/home':
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

    case '/chat':
      return MaterialPageRoute(
        builder: (context) => const ChatScreen(),
      );

    case '/testapi':
      return MaterialPageRoute(
        builder: (context) => const TestApi(),
      );

    case '/dashboard':
      return MaterialPageRoute(
        builder: (context) => const Dashboard(),
      );

    case '/sources':
      return MaterialPageRoute(
        builder: (context) => const NutrientsSourcesScreen(),
      );

    case '/nutrient':
      return MaterialPageRoute(
        builder: (context) => const NutrientScreen(),
      );

    case '/intakeInfo':
      return MaterialPageRoute(
        builder: (context) => const NutritionIntakeInfo(),
      );

    case '/colors':
      return MaterialPageRoute(
        builder: (context) => ColorPreviewScreen(),
      );

    case '/profile':
      return MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      );

    case '/settings':
      return MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      );

    // case '/updateapi':
    //   return MaterialPageRoute(
    //     builder: (context) => const UpdateApiKeyScreen(),
    //   );

    case FamilyNutritionScreen.route:
      return MaterialPageRoute(
        builder: (context) => const FamilyNutritionScreen(),
      );

    case '/prices':
      return MaterialPageRoute(
        builder: (context) => const PriceListScreen(),
      );

    case '/food_api_screen':
      return MaterialPageRoute(
        builder: (context) => const RecipeListScreen(),
      );

    case '/appearance':
      return MaterialPageRoute(
        builder: (context) => const Appearances(),
      );

    case '/addsource':
      FamilyMember? familyMember;
      if (settings.arguments != null) {
        familyMember = settings.arguments as FamilyMember;
      }
      return MaterialPageRoute(
        builder: (context) => SourceNeutrantScreen(member: familyMember!),
      );

    case FullScreenImage.route:
      final imageUrl = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: imageUrl),
      );

    case FamilyMemberDetails.route:
      FamilyMember? familyMember;
      if (settings.arguments != null) {
        familyMember = settings.arguments as FamilyMember;
      }
      return MaterialPageRoute(
        builder: (context) => FamilyMemberDetails(member: familyMember!),
      );

    case '/family/add':
      FamilyMember? familyMember;

      if (settings.arguments != null) {
        familyMember = settings.arguments as FamilyMember;
      }

      return MaterialPageRoute(
        builder: (context) => AddFamilyMemberScreen(familyMember: familyMember),
      );

    default:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}
