import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:nutrovite/core/extensions/media_query_extensions.dart';
import 'package:nutrovite/features/chat_bot/models/chat_model.dart';
import 'package:nutrovite/features/chat_bot/repositories/chat_repository.dart';
import 'package:nutrovite/features/chat_bot/widgets/message_bubble.dart';
import 'package:nutrovite/features/home/models/constants.dart';
import 'package:intl/intl.dart';
import 'package:nutrovite/features/settings/bloc/gemini_api.dart';
import 'package:nutrovite/main.dart';

const String apiKey = ServerConstants.apiKey;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  
  ChatRepository? _chatRepository;
  List<ChatMessage> _generatedContent = [];
  bool _loading = false;
  bool _dataFetched = false;
  bool _disposed = false;
  String? _lastError;

  late final Isar _isar;

  @override
  void initState() {
    super.initState();
    _isar = isar;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_dataFetched) {
      _initializeIsar();
    }
  }

  Future<void> _initializeIsar() async {
    if (_disposed) return;
    
    try {
      debugPrint('Initializing chat...');
      
      // Load messages
      await _loadMessages();
      
      // Initialize repository only if API key exists
      if (ServerConstants.apiKey.isNotEmpty && localUser != null) {
        _chatRepository = ChatRepository(ServerConstants.apiKey, localUser!);
      }
      
      if (!_disposed) {
        setState(() => _dataFetched = true);
      }
      debugPrint('Chat initialized successfully');
    } catch (e) {
      debugPrint('Error initializing chat: $e');
      if (!_disposed) {
        setState(() {
          _dataFetched = true;
          _lastError = 'Failed to initialize: ${e.toString()}';
        });
      }
    }
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await _isar.chatMessages
          .where()
          .sortByTimestamp()
          .findAll();
      
      if (!_disposed) {
        _generatedContent = messages;
      }
    } catch (e) {
      debugPrint('Error loading messages: $e');
      _generatedContent = [];
    }
  }

  Future<void> _saveMessage(ChatMessage message) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.chatMessages.put(message);
      });
    } catch (e) {
      debugPrint('Error saving message: $e');
      // Don't throw - allow UI to continue
    }
  }

  Future<void> _clearAllMessages() async {
    try {
      await _isar.writeTxn(() async {
        await _isar.chatMessages.clear();
      });
      
      if (!_disposed) {
        setState(() {
          _generatedContent.clear();
        });
      }
    } catch (e) {
      debugPrint('Error clearing messages: $e');
      _showError('Failed to clear messages: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Loading state
    if (!_dataFetched) {
      return Scaffold(
        appBar: AppBar(title: const Text('AI Nutritionist')),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Error state
    if (_lastError != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('AI Nutritionist')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: context.cScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error',
                  style: context.tTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.cScheme.error,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _lastError!,
                  textAlign: TextAlign.center,
                  style: context.tTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _lastError = null;
                      _dataFetched = false;
                    });
                    _initializeIsar();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // No API key state
    if (ServerConstants.apiKey.isEmpty || _chatRepository == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('AI Nutritionist')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.key_off,
                  size: 64,
                  color: context.cScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'No API Key Found',
                  textAlign: TextAlign.center,
                  style: context.tTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.cScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please configure your Gemini API key in settings to use the AI Nutritionist.',
                  textAlign: TextAlign.center,
                  style: context.tTheme.bodyMedium?.copyWith(
                    color: context.cScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Message limit state
    if (_generatedContent.length > (kDebugMode ? 1000 : 20)) {
      return Scaffold(
        appBar: AppBar(title: const Text('AI Nutritionist')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 64,
                  color: context.cScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Message Limit Reached',
                  textAlign: TextAlign.center,
                  style: context.tTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.cScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You have reached the maximum number of messages. Please clear your chat history to continue.',
                  textAlign: TextAlign.center,
                  style: context.tTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => _showClearDialog(),
                  icon: const Icon(Icons.delete),
                  label: const Text('Clear Chat History'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final textFieldDecoration = InputDecoration(
      hintText: 'Write message ...',
      filled: true,
      fillColor: context.cScheme.surfaceContainerHighest,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      suffixIcon: !_loading
          ? IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => _sendChatMessage(_textController.text),
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : Container(
              padding: const EdgeInsets.all(12),
              width: 24,
              height: 24,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('AI Nutritionist'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear chat history',
            onPressed: _generatedContent.isEmpty ? null : () => _showClearDialog(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
        child: Column(
          children: [
            Expanded(
              child: _generatedContent.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: context.cScheme.onSurfaceVariant.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Start a conversation',
                            style: context.tTheme.titleMedium?.copyWith(
                              color: context.cScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ask me anything about nutrition!',
                            style: context.tTheme.bodySmall?.copyWith(
                              color: context.cScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GroupedListView<ChatMessage, DateTime>(
                      controller: _scrollController,
                      elements: _generatedContent,
                      groupBy: (element) => DateTime(
                        element.timestamp.year,
                        element.timestamp.month,
                        element.timestamp.day,
                        element.timestamp.hour,
                      ),
                      groupSeparatorBuilder: (DateTime groupByValue) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: context.cScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _formatDate(groupByValue),
                              style: context.tTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: context.cScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ),
                      itemBuilder: (context, ChatMessage element) {
                        return MessageBubble(
                          timestamp: element.timestamp,
                          text: element.text,
                          image: element.imagePath != null
                              ? Image.asset(element.imagePath!)
                              : null,
                          isFromUser: element.fromUser,
                        );
                      },
                      order: GroupedListOrder.ASC,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 8, 5, 3),
              child: TextField(
                enabled: !_loading,
                autofocus: false,
                focusNode: _textFieldFocus,
                maxLines: null,
                textInputAction: TextInputAction.send,
                style: context.tTheme.bodyMedium?.copyWith(
                  color: context.cScheme.onSurface,
                ),
                decoration: textFieldDecoration,
                controller: _textController,
                onSubmitted: (value) => _sendChatMessage(value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    // Validation
    if (message.trim().isEmpty) {
      return;
    }

    if (_loading) {
      return; // Prevent duplicate sends
    }

    if (_chatRepository == null) {
      _showError('Chat service not initialized. Please restart the app.');
      return;
    }

    final trimmedMessage = message.trim();
    
    setState(() {
      _loading = true;
      _textController.clear();
    });

    try {
      // Create and add user message
      final userMessage = ChatMessage(
        text: trimmedMessage,
        imagePath: null,
        fromUser: true,
        timestamp: DateTime.now(),
      );
      
      setState(() {
        _generatedContent.add(userMessage);
      });
      
      // Save user message asynchronously (don't block UI)
      _saveMessage(userMessage).catchError((e) {
        debugPrint('Failed to save user message: $e');
      });
      
      // Scroll to bottom
      _scrollDown();

      // Get AI response
      final response = await _chatRepository!.sendChatMessage(trimmedMessage);
      
      if (_disposed) return;

      if (response == null || response.isEmpty) {
        throw Exception('Empty response from AI');
      }

      // Create and add bot message
      final botMessage = ChatMessage(
        text: response,
        imagePath: null,
        fromUser: false,
        timestamp: DateTime.now(),
      );
      
      setState(() {
        _generatedContent.add(botMessage);
        _loading = false;
      });

      // Save bot message asynchronously
      _saveMessage(botMessage).catchError((e) {
        debugPrint('Failed to save bot message: $e');
      });

      // Scroll to bottom
      _scrollDown();
      
    } catch (e, stackTrace) {
      debugPrint('Error sending message: $e');
      debugPrint('Stack trace: $stackTrace');
      
      if (!_disposed) {
        setState(() {
          _loading = false;
        });
        
        String errorMessage = 'Failed to send message';
        
        if (e.toString().contains('API key')) {
          errorMessage = 'Invalid API key. Please check your settings.';
        } else if (e.toString().contains('network') || 
                   e.toString().contains('connection')) {
          errorMessage = 'Network error. Please check your internet connection.';
        } else if (e.toString().contains('timeout')) {
          errorMessage = 'Request timed out. Please try again.';
        } else {
          errorMessage = 'Error: ${e.toString()}';
        }
        
        _showError(errorMessage);
      }
    } finally {
      if (!_disposed) {
        _textFieldFocus.requestFocus();
      }
    }
  }

  void _showError(String message) {
    if (_disposed || !mounted) return;
    
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 8),
              Text(
                'Error',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: SelectableText(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showClearDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Clear Chat History',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to clear the chat history? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _clearAllMessages();
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  void _scrollDown() {
    if (!mounted || _disposed) return;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return DateFormat('hh:mm a').format(date);
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    } else if (date.isAfter(startOfWeek) && date.isBefore(endOfWeek)) {
      return DateFormat.EEEE().format(date);
    } else {
      return DateFormat.yMMMd().format(date);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _scrollController.dispose();
    _textController.dispose();
    _textFieldFocus.dispose();
    super.dispose();
  }
}