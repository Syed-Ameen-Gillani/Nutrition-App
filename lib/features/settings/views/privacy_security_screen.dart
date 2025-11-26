import 'package:flutter/material.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool _analyticsEnabled = true;
  bool _personalizedTips = true;
  bool _localStorageEncryption = true;
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          Text(
            'Your data, your control',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Nutrovite only uses your data to personalize your nutrition experience on this device.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildSwitchTile(
                  context,
                  title: 'Usage analytics',
                  subtitle:
                      'Share anonymous usage data to help improve the app experience.',
                  value: _analyticsEnabled,
                  onChanged: (value) {
                    setState(() => _analyticsEnabled = value);
                  },
                ),
                const Divider(height: 0),
                _buildSwitchTile(
                  context,
                  title: 'Personalized nutrition tips',
                  subtitle:
                      'Use your profile and family data to tailor nutrition recommendations.',
                  value: _personalizedTips,
                  onChanged: (value) {
                    setState(() => _personalizedTips = value);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildSwitchTile(
                  context,
                  title: 'Encrypt local data',
                  subtitle:
                      'Secure saved nutrition data on this device where possible.',
                  value: _localStorageEncryption,
                  onChanged: (value) {
                    setState(() => _localStorageEncryption = value);
                  },
                ),
                const Divider(height: 0),
                _buildSwitchTile(
                  context,
                  title: 'Allow notifications',
                  subtitle:
                      'Receive reminders and nutrition tips (if enabled by the system).',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(
                Icons.description_outlined,
                color: colorScheme.primary,
              ),
              title: const Text('View privacy policy'),
              subtitle: Text(
                'Learn more about how your data is handled.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Privacy policy is not hosted yet. Connect this to your policy page when available.',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SwitchListTile.adaptive(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}


