import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'suger_terms_page.dart';
import 'suger_privacy_page.dart';
import '../utils/preference_helper.dart';
import '../main.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _hasAgreed = false;

  bool get _canEnter => _hasAgreed;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomPadding = MediaQuery.of(context).padding.bottom + 36;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/welocme_bg.webp',
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: bottomPadding),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _canEnter ? _enterApp : null,
                        child: Container(
                          width: screenWidth - 40,
                          height: 56,
                          decoration: BoxDecoration(
                            color: _canEnter
                                ? const Color(0xFF383838)
                                : const Color(0xFF383838).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: _canEnter
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFF383838).withOpacity(0.3),
                                      blurRadius: 18,
                                      offset: const Offset(0, 8),
                                    ),
                                  ]
                                : null,
                          ),
                          child: const Center(
                            child: Text(
                              'Enter App',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _hasAgreed = !_hasAgreed;
                                });
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.only(top: 2),
                                decoration: BoxDecoration(
                                  color: _hasAgreed
                                      ? const Color(0xFFFFC600)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: _hasAgreed
                                        ? const Color(0xFFFFC600)
                                        : Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: _hasAgreed
                                    ? const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Color(0xFF222222),
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _hasAgreed = !_hasAgreed;
                                  });
                                },
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 12,
                                    ),
                                    children: [
                                      const TextSpan(text: 'I have read and agree '),
                                      TextSpan(
                                        text: 'Terms of Service',
                                        style: const TextStyle(
                                          color: Color(0xFF2583FF),
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => const SugerTermsPage(),
                                              ),
                                            );
                                          },
                                      ),
                                      const TextSpan(text: ' and '),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: const TextStyle(
                                          color: Color(0xFF2583FF),
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => const SugerPrivacyPage(),
                                              ),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _enterApp() async {
    // 保存协议同意状态
    await PreferenceHelper.setAgreedToTerms(true);
    await PreferenceHelper.setAgreedToPrivacy(true);
    
    // 跳转到主应用
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const TabShell(),
        ),
      );
    }
  }
}

