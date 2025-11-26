import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:nutrovite/core/routes/routes.dart';
import 'package:nutrovite/core/themes/color_scheme.dart';
import 'package:nutrovite/features/auth/views/screens/splash_screen.dart';
import 'package:nutrovite/features/settings/bloc/gemini_api.dart';
import 'package:nutrovite/features/settings/bloc/theme_cubit.dart';
import 'package:nutrovite/features/auth/repositories/auth_repository.dart';
import 'package:nutrovite/features/auth/views/screens/welcome_screen.dart';
import 'package:nutrovite/features/home/view_models/navigation_cubit.dart';
import 'package:nutrovite/features/home/views/home_screen.dart';
import 'package:nutrovite/isardb_schemeas.dart';
import 'package:path_provider/path_provider.dart';
import 'features/auth/models/user_model.dart';
import 'features/auth/view_models/bloc/auth_bloc.dart';
import 'firebase_options.dart';

late Isar isar;
late UserModel? localUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    isarDbSchemeas,
    directory: dir.path,
  );

  final users = await isar.userModels.where(distinct: true).findAll();
  localUser = users.isEmpty ? null : users.first;
  print('LocalUser : $localUser');

  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => ChatBloc(ChatRepository('', ))),
        // BlocProvider(create: (_) => FamilyMemberCubit()),
        BlocProvider(create: (context) => ThemeModeCubit(isar)),
        BlocProvider(create: (context) => GeminiApiCubit(isar)),
        BlocProvider(create: (context) => NavigationCubit(0)),
        BlocProvider(
          create: (_) => AuthBloc(
            authRepository: AuthRepository(isar),
          ),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          themeMode: state,
          title: 'Nutrovite',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorSchemes.light,
            useMaterial3: true,
            textTheme: GoogleFonts.interTextTheme(),
            appBarTheme: AppBarTheme(
              // backgroundColor: NavigationBarTheme.of(context).backgroundColor,
              foregroundColor: ColorSchemes.light.onSurface,
              elevation: 0,
            ),
            scaffoldBackgroundColor: ColorSchemes.light.surface,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorSchemes.dark,
            useMaterial3: true,
            textTheme: GoogleFonts.interTextTheme(),
            appBarTheme: AppBarTheme(
              titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 18,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
              // backgroundColor: NavigationBarTheme.of(context).backgroundColor,
              foregroundColor: ColorSchemes.dark.onSurface,
              elevation: 0,
            ),
            scaffoldBackgroundColor: ColorSchemes.dark.surface,
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              if (snapshot.hasData) {
                return const HomeScreen();
              }
              return const WelcomeScreen();
            },
          ),
          onGenerateRoute: (settings) => onGenerateRoute(settings),
        );
      },
    );
  }
}
