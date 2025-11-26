import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:nutrovite/core/extensions/media_query_extensions.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    this.image,
    this.text,
    required this.isFromUser,
    required this.timestamp,
  });

  final Image? image;
  final String? text;
  final bool isFromUser;
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isFromUser)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              maxRadius: 18,
              backgroundColor: context.cScheme.surfaceContainerHighest,
              child: Text(
                'AI', // Placeholder for user's avatar initials
                style: context.tTheme.titleSmall!.copyWith(
                  color: context.cScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment:
                isFromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 520),
                decoration: BoxDecoration(
                  color: isFromUser
                      ? context.cScheme.primaryContainer
                      : context.cScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isFromUser ? 18 : 4),
                    topRight: const Radius.circular(18),
                    bottomLeft: Radius.circular(isFromUser ? 4 : 18),
                    bottomRight: Radius.circular(isFromUser ? 18 : 4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                margin: const EdgeInsets.only(bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (text != null)
                      MarkdownBody(
                        data: text!,
                        selectable: true,
                        styleSheet: MarkdownStyleSheet(
                          p: context.tTheme.bodyMedium!.copyWith(
                            color: isFromUser
                                ? context.cScheme.onSurface
                                : context.cScheme.onPrimaryContainer,
                          ),
                          a: context.tTheme.bodyMedium!.copyWith(
                            color: isFromUser
                                ? context.cScheme.onSurface
                                : context.cScheme.onPrimaryContainer,
                          ),
                          blockquote: context.tTheme.bodyMedium!.copyWith(
                            color: isFromUser
                                ? context.cScheme.onSurface
                                : context.cScheme.onPrimaryContainer,
                          ),
                          blockquoteDecoration: BoxDecoration(
                            color: isFromUser
                                ? context.cScheme.onSurface.withOpacity(0.1)
                                : context.cScheme.onPrimaryContainer
                                    .withOpacity(0.1),
                          ),
                          code: context.tTheme.bodyMedium!.copyWith(
                            color: isFromUser
                                ? context.cScheme.onSurface
                                : context.cScheme.onPrimaryContainer,
                          ),
                          h1: context.tTheme.headlineMedium!.copyWith(
                            color: isFromUser
                                ? context.cScheme.onSurface
                                : context.cScheme.onPrimaryContainer,
                          ),
                          h2: context.tTheme.headlineSmall!.copyWith(
                            color: isFromUser
                                ? context.cScheme.onSurface
                                : context.cScheme.onPrimaryContainer,
                          ),
                          h3: context.tTheme.titleLarge!.copyWith(
                            color: isFromUser
                                ? context.cScheme.onSurface
                                : context.cScheme.onPrimaryContainer,
                          ),
                          h4: context.tTheme.titleMedium!.copyWith(
                            color: isFromUser
                                ? context.cScheme.onSurface
                                : context.cScheme.onPrimaryContainer,
                          ),
                          h5: context.tTheme.titleSmall!.copyWith(
                            color: isFromUser
                                ? context.cScheme.onSurface
                                : context.cScheme.onPrimaryContainer,
                          ),
                          h6: context.tTheme.labelLarge!.copyWith(
                            color: isFromUser
                                ? context.cScheme.onSurface
                                : context.cScheme.onPrimaryContainer,
                          ),
                          listBullet: context.tTheme.bodyMedium!.copyWith(
                            color: isFromUser
                                ? context.cScheme.onSurface
                                : context.cScheme.onPrimaryContainer,
                          ),
                          // Define other text styles as needed
                        ),
                      ),
                    if (image != null) ...[
                      const SizedBox(height: 8),
                      image!,
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('hh:mm a').format(timestamp),
                style: context.tTheme.bodySmall!.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        if (isFromUser)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              maxRadius: 18,
              backgroundColor: context.cScheme.primaryContainer,
              child: Text(
                'ME', // Placeholder for user's avatar initials
                style: context.tTheme.titleSmall!.copyWith(
                  color: context.cScheme.onSurface,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
