import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          Text(
            'How can we help?',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Browse common questions or reach out if you need more help.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          _buildActionCard(
            context,
            icon: Icons.chat_bubble_outline,
            title: 'Contact support',
            subtitle: 'Send us a message with your issue or feedback.',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Hook this up to your preferred support channel (email, chat, etc.).',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildActionCard(
            context,
            icon: Icons.bug_report_outlined,
            title: 'Report a bug',
            subtitle: 'Found something not working? Let us know.',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Bug report flow not connected yet. You can wire this to an issue tracker or email.',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            'FAQs',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _buildFaqTile(
            context,
            question: 'How does Nutrovite use my data?',
            answer:
                'Nutrovite uses your profile, family members, and nutrition selections only to personalize your experience on this device. You can control analytics and personalization from Privacy & Security.',
          ),
          _buildFaqTile(
            context,
            question: 'Why am I not seeing any food sources?',
            answer:
                'Make sure you\'re connected to the internet. If the remote data source is unavailable, Nutrovite will show a limited set of built-in examples.',
          ),
          _buildFaqTile(
            context,
            question: 'Are the nutrition recommendations medical advice?',
            answer:
                'No. Nutrovite provides general guidance based on public nutrition guidelines and is not a substitute for professional medical advice. Always consult a healthcare professional for medical decisions.',
          ),
          _buildFaqTile(
            context,
            question: 'How do I reset my account data?',
            answer:
                'You can update your profile from Account settings. To completely remove your data, contact support so we can guide you through the process.',
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: colorScheme.primary.withOpacity(0.1),
          child: Icon(
            icon,
            color: colorScheme.primary,
          ),
        ),
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
        onTap: onTap,
      ),
    );
  }

  Widget _buildFaqTile(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          question,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


