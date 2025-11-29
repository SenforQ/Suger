import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessagePage extends StatefulWidget {
  const MessagePage({
    super.key,
    required this.character,
    required this.userIcon,
    required this.nickName,
    required this.greeting,
  });

  final Map<String, dynamic> character;
  final String userIcon;
  final String nickName;
  final String greeting;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  static const String _apiKey =
      '873dd73db0a344deb33292bfb0d12fc1.CKYh2BDZ5EMCUUUw';
  static const String _apiUrl =
      'https://open.bigmodel.cn/api/paas/v4/chat/completions';
  
  final TextEditingController _textController = TextEditingController();
  final List<_ChatMessage> _messages = [];
  bool _isSending = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messages.add(
      _ChatMessage(
        content: widget.greeting,
        isUser: false,
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    final prompt = _textController.text.trim();
    if (prompt.isEmpty || _isSending) return;

    setState(() {
      _messages.add(
        _ChatMessage(
          content: prompt,
          isUser: true,
        ),
      );
      _isSending = true;
      _textController.clear();
    });

    _scrollToBottom();

    final response = await _requestChat(prompt);

    if (!mounted) return;

    setState(() {
      if (response != null) {
        _messages.add(
          _ChatMessage(
            content: response,
            isUser: false,
          ),
        );
      } else {
        _messages.add(
          const _ChatMessage(
            content: 'Sorry, I encountered an error. Please try again.',
            isUser: false,
          ),
        );
      }
      _isSending = false;
    });

    _scrollToBottom();
  }

  Future<void> _scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<String?> _requestChat(String userMessage) async {
    try {
      // 构建消息历史
      final List<Map<String, String>> messages = [];
      
      // 添加系统提示
      messages.add({
        'role': 'system',
        'content': 'You are ${widget.nickName}, a creative AI character. Respond in English naturally and engagingly.',
      });
      
      // 添加历史消息（除了第一条问候语）
      for (int i = 1; i < _messages.length; i++) {
        messages.add({
          'role': _messages[i].isUser ? 'user' : 'assistant',
          'content': _messages[i].content,
        });
      }
      
      // 添加当前用户消息
      messages.add({
        'role': 'user',
        'content': userMessage,
      });

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'glm-4-flash',
          'messages': messages,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode != 200) {
        return null;
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic>? choices = data['choices'] as List<dynamic>?;
      if (choices == null || choices.isEmpty) {
        return null;
      }

      final dynamic firstChoice = choices.first;
      if (firstChoice is Map<String, dynamic>) {
        final dynamic message = firstChoice['message'];
        if (message is Map<String, dynamic>) {
          final String? content = message['content'] as String?;
          return content;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9E5),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(widget.userIcon),
            ),
            const SizedBox(width: 12),
            Text(
              widget.nickName,
              style: const TextStyle(
                color: Color(0xFF1D1D1D),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFFC600),
        elevation: 0,
        foregroundColor: const Color(0xFF222222),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/bg_home_nor.webp',
                width: screenWidth,
                height: screenHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return Align(
                      alignment: message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: message.isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!message.isUser)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundImage: AssetImage(widget.userIcon),
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            constraints: const BoxConstraints(maxWidth: 280),
                            decoration: BoxDecoration(
                              color: message.isUser
                                  ? const Color(0xFFFFC600)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Text(
                              message.content,
                              style: TextStyle(
                                color: message.isUser
                                    ? const Color(0xFF222222)
                                    : const Color(0xFF5A5A5A),
                                fontSize: 15,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              _ChatComposer(
                controller: _textController,
                onSend: _handleSend,
                isSending: _isSending,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer({
    required this.controller,
    required this.onSend,
    required this.isSending,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: isSending ? null : onSend,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isSending
                      ? const Color(0xFFFFC600).withOpacity(0.4)
                      : const Color(0xFFFFC600),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFC600).withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: isSending
                    ? const Padding(
                        padding: EdgeInsets.all(14),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          valueColor:
                              AlwaysStoppedAnimation(Color(0xFF222222)),
                        ),
                      )
                    : const Icon(
                        Icons.send,
                        color: Color(0xFF222222),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.content,
    required this.isUser,
  });

  final String content;
  final bool isUser;
}

