import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrovite/core/extensions/media_query_extensions.dart';
import 'package:nutrovite/features/auth/view_models/bloc/auth_bloc.dart';
import 'package:nutrovite/features/auth/views/screens/login_screen.dart';
import 'package:nutrovite/features/auth/views/widgets/auth_button.dart';

// Define a custom class for the settings items
class SettingItem {
  final IconData icon;
  final String label;
  final String path;
  final List<SettingItem> nestedSettings;

  SettingItem({
    required this.icon,
    required this.label,
    required this.path,
    required this.nestedSettings,
  });
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // List of settings items using the custom SettingItem class
  final List<SettingItem> _settingsItems = [
    SettingItem(
      icon: Icons.person_2_rounded,
      label: 'Account',
      path: '/profile',
      nestedSettings: [],
    ),
    SettingItem(
      icon: Icons.remove_red_eye_rounded,
      label: 'Appearance',
      path: '/appearance',
      nestedSettings: [],
    ),
    SettingItem(
      icon: Icons.lock_rounded,
      label: 'Privacy & Security',
      path: '/privacy',
      nestedSettings: [],
    ),
    SettingItem(
      icon: Icons.headset_mic_rounded,
      label: 'Help and Support',
      path: '/help_support',
      nestedSettings: [],
    ),
    SettingItem(
      icon: Icons.info_rounded,
      label: 'About',
      path: '/about',
      nestedSettings: [],
    ),
  ];

  String _searchQuery = "";

  // Advanced search that includes nested sub-settings
  List<SettingItem> get _filteredSettings {
    if (_searchQuery.isEmpty) {
      return _settingsItems;
    }
    return _settingsItems.where((item) {
      final labelMatch =
          item.label.toLowerCase().contains(_searchQuery.toLowerCase());
      return labelMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          // Navigate to the sign-in screen after sign-out
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
            (Route<dynamic> route) => false,
          );
        } else if (state is AuthError) {
          // Handle errors if necessary
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: const Text('Settings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.all(0),
                    hintText: "Search settings...",
                    filled: true,
                    fillColor: Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredSettings.length,
                itemBuilder: (context, index) {
                  final setting = _filteredSettings[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: SizedBox(
                      height: context.height * 0.09,
                      child: Center(
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          leading: Icon(setting.icon),
                          title: Text(
                            setting.label,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ),
                          onTap: () {
                            if (setting.path.isNotEmpty) {
                              Navigator.of(context).pushNamed(setting.path);
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: context.width * 0.7,
                child: CustomSubmitButton(
                  onPressed: () {
                    // Dispatch the sign-out event
                    context.read<AuthBloc>().add(AuthLogoutEvent());
                  },
                  label: 'Logout',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
