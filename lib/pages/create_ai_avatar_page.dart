import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/ai_style.dart';

class CreateAiAvatarPage extends StatefulWidget {
  const CreateAiAvatarPage({
    super.key,
    required this.initialStyle,
  });

  final AiStyle initialStyle;

  @override
  State<CreateAiAvatarPage> createState() => _CreateAiAvatarPageState();
}

class _CreateAiAvatarPageState extends State<CreateAiAvatarPage> {
  static const String _apiKey =
      '873dd73db0a344deb33292bfb0d12fc1.CKYh2BDZ5EMCUUUw';
  static const String _apiUrl =
      'https://open.bigmodel.cn/api/paas/v4/images/generations';
  final TextEditingController _textController = TextEditingController();
  final List<_ChatMessage> _messages = [];
  bool _isSending = false;
  late AiStyle _currentStyle;

  @override
  void initState() {
    super.initState();
    _currentStyle = widget.initialStyle;
    _messages.add(
      const _ChatMessage(
        content:
            'Hi, I’m your AI artist. Tell me what kind of avatar you need and I’ll craft it for you!',
        isUser: false,
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
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

    final imageUrl = await _requestImage(prompt);

    if (!mounted) return;

    setState(() {
      if (imageUrl != null) {
        _messages.add(
          _ChatMessage(
            content: 'Here is your AI avatar.',
            isUser: false,
            imageUrl: imageUrl,
          ),
        );
      } else {
        _messages.add(
          const _ChatMessage(
            content:
                'Failed to generate the image. Please try again in a moment.',
            isUser: false,
          ),
        );
      }
      _isSending = false;
    });
  }

  Future<String?> _requestImage(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'cogview-3-flash',
          'prompt': prompt,
          'size': '1024x1024',
          'n': 1,
        }),
      );

      if (response.statusCode != 200) {
        return null;
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic>? results = data['data'] as List<dynamic>?;
      if (results == null || results.isEmpty) {
        return null;
      }

      final dynamic first = results.first;
      if (first is Map<String, dynamic>) {
        if (first['url'] != null) {
          return first['url'] as String;
        }
        if (first['b64_json'] != null) {
          final String b64 = first['b64_json'] as String;
          return 'data:image/png;base64,$b64';
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9E5),
      appBar: AppBar(
        title: const Text('Create AI Avatar'),
        backgroundColor: const Color(0xFFFFC600),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(_currentStyle.smallAsset),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                _currentStyle.largeAsset,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: message.isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!message.isUser) ...[
                            CircleAvatar(
                              radius: 18,
                              backgroundImage:
                                  AssetImage(_currentStyle.smallAsset),
                            ),
                            const SizedBox(width: 10),
                          ],
                          Container(
                            padding: const EdgeInsets.all(12),
                            constraints: const BoxConstraints(maxWidth: 260),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.content,
                                  style: TextStyle(
                                    color: message.isUser
                                        ? const Color(0xFF222222)
                                        : const Color(0xFF5A5A5A),
                                    fontSize: 15,
                                    height: 1.4,
                                  ),
                                ),
                                if (message.imageUrl != null) ...[
                                  const SizedBox(height: 12),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.network(
                                      message.imageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Text(
                                        'Unable to load image preview.',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (message.isUser) ...[
                            const SizedBox(width: 10),
                            const CircleAvatar(
                              radius: 18,
                              backgroundColor: Color(0xFFFFC600),
                              child: Icon(
                                Icons.person,
                                color: Color(0xFF222222),
                              ),
                            ),
                          ],
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
                    hintText: 'Describe the avatar you want...',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8, width: 12),
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
    this.imageUrl,
  });

  final String content;
  final bool isUser;
  final String? imageUrl;
}

