import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aiforexam/base_scaffold.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  bool _enableReasoning = false;
  String _selectedSubject = 'General';

  // Replace with your actual Gemini API key
  static const String _apiKey = 'YOUR_GEMINI_API_KEY_HERE';
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  final List<String> _subjects = [
    'General',
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'History',
    'Literature',
    'Computer Science',
    'Economics',
    'Philosophy'
  ];

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.add(ChatMessage(
      text: "Hello! I'm your AI study assistant. Ask me any question and I can provide detailed explanations with step-by-step reasoning if needed. How can I help you today?",
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text.trim();
    _messageController.clear();

    setState(() {
      _messages.add(ChatMessage(
        text: userMessage,
        isUser: true,
        timestamp: DateTime.now(),
        subject: _selectedSubject,
        withReasoning: _enableReasoning,
      ));
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      final response = await _callGeminiAPI(userMessage);
      setState(() {
        _messages.add(ChatMessage(
          text: response,
          isUser: false,
          timestamp: DateTime.now(),
        ));
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: "Sorry, I encountered an error: ${e.toString()}",
          isUser: false,
          timestamp: DateTime.now(),
          isError: true,
        ));
        _isLoading = false;
      });
    }

    _scrollToBottom();
  }

  Future<String> _callGeminiAPI(String message) async {
    // Construct the prompt based on user preferences
    String prompt = _buildPrompt(message);

    final response = await http.post(
      Uri.parse('$_baseUrl?key=$_apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'contents': [{
          'parts': [{
            'text': prompt
          }]
        }],
        'generationConfig': {
          'temperature': 0.7,
          'topK': 40,
          'topP': 0.95,
          'maxOutputTokens': 1024,
        }
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Failed to get response from Gemini API: ${response.statusCode}');
    }
  }

  String _buildPrompt(String message) {
    String prompt = '';

    if (_selectedSubject != 'General') {
      prompt += 'Context: This is a $_selectedSubject question. ';
    }

    if (_enableReasoning) {
      prompt += 'Please provide a detailed step-by-step explanation with reasoning for: ';
    } else {
      prompt += 'Please provide a clear and concise answer for: ';
    }

    prompt += message;

    if (_enableReasoning) {
      prompt += '\n\nPlease structure your response with:\n1. Brief answer\n2. Detailed explanation\n3. Step-by-step reasoning\n4. Key concepts involved';
    }

    return prompt;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
      _addWelcomeMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 3,
      body: Column(
        children: [
          // Header with options
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(),
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.smart_toy, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Text(
                      'AI Study Assistant',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _clearChat,
                      icon: const Icon(Icons.clear_all),
                      tooltip: 'Clear Chat',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // Subject Selection
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedSubject,
                        decoration: const InputDecoration(
                          labelText: 'Subject',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        items: _subjects.map((subject) {
                          return DropdownMenuItem(
                            value: subject,
                            child: Text(subject),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSubject = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Reasoning Toggle
                    Column(
                      children: [
                        Switch(
                          value: _enableReasoning,
                          onChanged: (value) {
                            setState(() {
                              _enableReasoning = value;
                            });
                          },
                        ),
                        const Text(
                          'Detailed\nReasoning',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Chat Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isLoading) {
                  return const ChatLoadingWidget();
                }
                return ChatMessageWidget(message: _messages[index]);
              },
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Ask me anything...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _isLoading ? null : _sendMessage,
                  mini: true,
                  child: _isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? subject;
  final bool? withReasoning;
  final bool isError;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.subject,
    this.withReasoning,
    this.isError = false,
  });
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: message.isError
                  ? Colors.red.withOpacity(0.2)
                  : Colors.blue.withOpacity(0.2),
              child: Icon(
                message.isError ? Icons.error : Icons.smart_toy,
                color: message.isError ? Colors.red : Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: message.isUser
                        ? Theme.of(context).primaryColor
                        : message.isError
                        ? Colors.red.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.isUser && message.subject != null) ...[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.subject,
                              size: 16,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              message.subject!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (message.withReasoning == true) ...[
                              const SizedBox(width: 8),
                              Icon(
                                Icons.psychology,
                                size: 16,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                      Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUser ? Colors.white : null,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTimestamp(message.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
              child: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

class ChatLoadingWidget extends StatelessWidget {
  const ChatLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue.withOpacity(0.2),
            child: const Icon(Icons.smart_toy, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'AI is thinking...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
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