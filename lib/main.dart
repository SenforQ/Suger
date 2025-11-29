import 'package:flutter/material.dart';

import 'pages/tab_four_page.dart';
import 'pages/tab_one_page.dart';
import 'pages/tab_three_page.dart';
import 'pages/tab_two_page.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFE207),
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}

class TabShell extends StatefulWidget {
  const TabShell({super.key});

  @override
  State<TabShell> createState() => _TabShellState();
}

class _TabShellState extends State<TabShell> {
  final List<Widget> _pages = const [
    TabOnePage(),
    TabTwoPage(),
    TabThreePage(),
    TabFourPage(),
  ];

  int _currentIndex = 0;

  void _onTabTap(int index) {
    if (_currentIndex == index) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double bottomOffset = MediaQuery.of(context).padding.bottom + 12;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomOffset,
            child: _FloatingTabBar(
              currentIndex: _currentIndex,
              onTap: _onTabTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingTabBar extends StatelessWidget {
  const _FloatingTabBar({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: 92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TabItem(
            index: 0,
            isSelected: currentIndex == 0,
            normalAsset: 'assets/icon_tab_home_nor.webp',
            selectedAsset: 'assets/icon_tab_home_pre.webp',
            onTap: onTap,
          ),
          _TabItem(
            index: 1,
            isSelected: currentIndex == 1,
            normalAsset: 'assets/icon_tab_ai_nor.webp',
            selectedAsset: 'assets/icon_tab_ai_pre.webp',
            onTap: onTap,
          ),
          _TabItem(
            index: 2,
            isSelected: currentIndex == 2,
            normalAsset: 'assets/icon_tab_interpret_nor.webp',
            selectedAsset: 'assets/icon_tab_interpret_pre.webp',
            onTap: onTap,
          ),
          _TabItem(
            index: 3,
            isSelected: currentIndex == 3,
            normalAsset: 'assets/icon_tab_profile_nor.webp',
            selectedAsset: 'assets/icon_tab_profile_pre.webp',
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.index,
    required this.isSelected,
    required this.normalAsset,
    required this.selectedAsset,
    required this.onTap,
  });

  final int index;
  final bool isSelected;
  final String normalAsset;
  final String selectedAsset;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap(index),
      child: SizedBox(
        width: 72,
        height: 92,
        child: Image.asset(
          isSelected ? selectedAsset : normalAsset,
          width: 72,
          height: 92,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
