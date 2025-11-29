import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SugerPrivacyPage extends StatefulWidget {
  const SugerPrivacyPage({super.key});

  @override
  State<SugerPrivacyPage> createState() => _SugerPrivacyPageState();
}

class _SugerPrivacyPageState extends State<SugerPrivacyPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(
        Uri.parse(
          'https://www.privacypolicies.com/live/8784fafd-1c2d-4a4b-9d36-45d2011513b4',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    const double navBarHeight = 56;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double availableHeight = screenHeight - statusBarHeight - navBarHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: statusBarHeight,
            left: 0,
            right: 0,
            height: navBarHeight,
            child: _BrowserHeader(
              title: 'Privacy Policy',
              onBack: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            top: statusBarHeight + navBarHeight,
            left: 0,
            right: 0,
            height: availableHeight,
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}

class _BrowserHeader extends StatelessWidget {
  const _BrowserHeader({
    required this.title,
    required this.onBack,
  });

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            color: Colors.black87,
            onPressed: onBack,
          ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}

