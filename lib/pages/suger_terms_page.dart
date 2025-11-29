import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SugerTermsPage extends StatefulWidget {
  const SugerTermsPage({super.key});

  @override
  State<SugerTermsPage> createState() => _SugerTermsPageState();
}

class _SugerTermsPageState extends State<SugerTermsPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..loadRequest(
        Uri.parse(
          'https://www.privacypolicies.com/live/ae8ff0fc-1230-43df-b1f5-18c50f77f95b',
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
              title: 'User Contract',
              onBack: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            top: statusBarHeight + navBarHeight,
            left: 0,
            right: 0,
            height: availableHeight,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: WebViewWidget(controller: _controller),
            ),
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

