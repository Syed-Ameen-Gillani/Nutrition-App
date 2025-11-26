import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:nutrovite/features/auth/models/user_model.dart';
import 'package:nutrovite/features/home/view_models/navigation_cubit.dart';
import 'package:nutrovite/features/settings/views/profile_screen.dart';
import 'package:nutrovite/main.dart';
import 'dashboard.dart';
import 'family_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      final users = await isar.userModels.where(distinct: true).findAll();
      localUser = users.isEmpty ? null : users.first;
      log('LocalUser : $localUser');
      // final userProvider = UserProvider();
      // await userProvider.initUser(isar);
      setState(() => loading = false);
    } catch (e) {
      log('Error fetching data: $e');
      setState(() => loading = false);
      // Optionally, show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationCubit = context.read<NavigationCubit>();

    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            leading: Container(
              padding: const EdgeInsets.all(8.0),
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundImage: AssetImage('assets/images/output.png'),
              ),
            ),
            elevation: 0,
            title: state == 0 ? const Text('Nutrovite') : const Text('Family'),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/settings');
                },
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: firebaseUser.photoURL ?? '',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              switch (navigationCubit.index) {
                case 0:
                  return const Dashboard();
                case 1:
                  return const FamilyNutritionScreen();
                default:
                  return const Dashboard();
              }
            },
          ),

          // return PageView(
          //   controller: navigationCubit.pageController,
          //   onPageChanged: (int page) {
          //     // Update selected tab when swiped
          //     context.read<NavigationCubit>().navigateToTab(page);
          //   },
          //   children: const <Widget>[
          //     Dashboard(),
          //     FamilyNutritionScreen(),
          //   ],
          // );
          bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
            builder: (context, selectedIndex) {
              return NavigationBar(
                selectedIndex: selectedIndex,
                onDestinationSelected: (int index) {
                  context.read<NavigationCubit>().navigateToTab(index);
                },
                destinations: const <NavigationDestination>[
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.family_restroom_outlined),
                    selectedIcon: Icon(Icons.family_restroom),
                    label: 'Family',
                  ),
                  // Uncomment if you add more tabs
                  // NavigationDestination(
                  //   icon: Icon(Icons.source_outlined),
                  //   selectedIcon: Icon(Icons.source),
                  //   label: 'Sources',
                  // ),
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => state == 0
                ? Navigator.of(context).pushNamed('/chat')
                : Navigator.of(context).pushNamed('/family/add'),
            child: Icon(
              (state == 0)
                  ? Icons.assistant_rounded
                  : Icons.person_add_alt_rounded,
            ),
          ),
        );
      },
    );
  }
}
