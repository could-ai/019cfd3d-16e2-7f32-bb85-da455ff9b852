import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'isAi': true,
      'text': 'Hi Alex! I\\'ve analyzed your inbox and Slack messages from last night. I drafted your daily standup update and approved 3 routine expense reports for your team. Would you like to review them?',
    }
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add({
        'isAi': false,
        'text': _controller.text,
      });
      _controller.clear();
    });

    // Mock AI response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'isAi': true,
            'text': 'I\\'ve scheduled a 15-minute focus block for you to review those items. I also noticed you\\'ve been working late this week—don\\'t forget to take a screen break today! 🌿',
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, size: 20),
            SizedBox(width: 8),
            Text('AI Assistant'),
          ],
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 1,
        shadowColor: theme.colorScheme.shadow.withOpacity(0.2),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isAi = msg['isAi'] as bool;
                
                return Align(
                  alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    decoration: BoxDecoration(
                      color: isAi 
                          ? theme.colorScheme.secondaryContainer 
                          : theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomLeft: isAi ? const Radius.circular(0) : const Radius.circular(16),
                        bottomRight: !isAi ? const Radius.circular(0) : const Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      msg['text'] as String,
                      style: TextStyle(
                        color: isAi 
                            ? theme.colorScheme.onSecondaryContainer 
                            : theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask AI to automate a task...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surfaceContainerHighest,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: theme.colorScheme.primary,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
