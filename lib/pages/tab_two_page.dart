import 'package:flutter/material.dart';

import '../models/ai_style.dart';
import '../services/coin_service.dart';
import '../utils/preference_helper.dart';
import '../utils/toast_utils.dart';
import 'create_ai_avatar_page.dart';

class TabTwoPage extends StatefulWidget {
  const TabTwoPage({super.key});

  @override
  State<TabTwoPage> createState() => _TabTwoPageState();
}

class _TabTwoPageState extends State<TabTwoPage> {
  final List<AiStyle> _styles = const [
    AiStyle(
      title: 'Real',
      smallAsset: 'assets/ai_real_small.png',
      largeAsset: 'assets/ai_real_big.webp',
    ),
    AiStyle(
      title: 'Anime',
      smallAsset: 'assets/ai_anime_small.png',
      largeAsset: 'assets/ai_anime_big.webp',
    ),
    AiStyle(
      title: '3D',
      smallAsset: 'assets/ai_3d_small.png',
      largeAsset: 'assets/ai_3d_big.webp',
    ),
  ];

  int _selectedIndex = 1;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _selectedIndex,
      viewportFraction: 0.55,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleCreateAvatar() async {
    final isVip = await PreferenceHelper.isVipActive();
    final freeCount = isVip 
        ? await PreferenceHelper.getVipFreePaintingCount()
        : await PreferenceHelper.getFreePaintingCount();
    final coins = await CoinService.getCurrentCoins();
    const requiredCoins = 120;

    final bool canUseFree = freeCount > 0;
    final bool hasEnoughCoins = coins >= requiredCoins;

    if (canUseFree) {
      final result = await _showFreeUsageDialog(isVip, freeCount);
      if (result == true) {
        await PreferenceHelper.useFreePainting();
        _navigateToCreatePage();
      }
    } else if (hasEnoughCoins) {
      final result = await _showCoinUsageDialog(coins, requiredCoins);
      if (result == true) {
        final success = await CoinService.deductCoins(requiredCoins);
        if (success) {
          showCenterToast(context, 'Coins deducted successfully');
          _navigateToCreatePage();
        } else {
          showCenterToast(context, 'Failed to deduct coins');
        }
      }
    } else {
      await _showInsufficientResourcesDialog(isVip, freeCount, coins, requiredCoins);
    }
  }

  Future<bool?> _showFreeUsageDialog(bool isVip, int freeCount) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.brush, color: Color(0xFFFFCC1B)),
            SizedBox(width: 12),
            Text(
              'Free Usage Available',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isVip
                  ? 'You have $freeCount free painting uses remaining this month (VIP benefit: 10 free uses per month).'
                  : 'You have $freeCount free painting uses remaining (Welcome bonus: 3 free uses).',
              style: const TextStyle(
                color: Color(0xFFCCCCCC),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Use a free painting now?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF999999)),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFCC1B),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Use Free',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showCoinUsageDialog(int currentCoins, int requiredCoins) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.monetization_on, color: Color(0xFFFFCC1B)),
            SizedBox(width: 12),
            Text(
              'Coins Required',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Using AI painting requires 120 Coins.',
              style: TextStyle(
                color: Color(0xFFCCCCCC),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your coins: $currentCoins',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Required: $requiredCoins Coins',
              style: const TextStyle(
                color: Color(0xFFFFCC1B),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF999999)),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFCC1B),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Use Coins',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showInsufficientResourcesDialog(
    bool isVip,
    int freeCount,
    int currentCoins,
    int requiredCoins,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Color(0xFFFF6B6B)),
            SizedBox(width: 12),
            Text(
              'Insufficient Resources',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isVip
                  ? 'You have used all your free painting uses this month (VIP: 10 free uses per month).'
                  : 'You have used all your free painting uses (Welcome bonus: 3 free uses).',
              style: const TextStyle(
                color: Color(0xFFCCCCCC),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your coins: $currentCoins',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Required: $requiredCoins Coins',
              style: const TextStyle(
                color: Color(0xFFFF6B6B),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please purchase more coins to continue.',
              style: TextStyle(
                color: Color(0xFFCCCCCC),
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFFFFCC1B)),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCreatePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateAiAvatarPage(
          initialStyle: _styles[_selectedIndex],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/base_ai_bg.webp',
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/base_bg_botoom.webp',
              width: screenWidth,
              height: 82,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text(
                        'Creation',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: const Color(0xFF1D1D1D),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 290,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: _styles.length,
                            onPageChanged: (index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              final bool isSelected = index == _selectedIndex;
                              final double cardWidth = isSelected ? 190 : 170;
                              final double cardHeight = isSelected ? 240 : 215;
                              return Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _pageController.animateToPage(
                                      index,
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeOut,
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    width: cardWidth,
                                    height: cardHeight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26),
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.16),
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.12),
                                          blurRadius: 18,
                                          offset: const Offset(0, 12),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(22),
                                      child: Image.asset(
                                        _styles[index].smallAsset,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        _StyleSelector(
                          styles: _styles,
                          selectedIndex: _selectedIndex,
                          onSelected: (index) {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => _handleCreateAvatar(),
                          child: Container(
                            width: screenWidth - 40,
                            height: 56,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFC600),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFFC600).withOpacity(0.4),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Create AI Avatar',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
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

class _StyleSelector extends StatelessWidget {
  const _StyleSelector({
    required this.styles,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<AiStyle> styles;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(styles.length, (index) {
        final bool isSelected = index == selectedIndex;
        return Padding(
          padding: EdgeInsets.only(right: index == styles.length - 1 ? 0 : 16),
          child: GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              width: 82,
              height: 38,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFC600) : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(24),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFFFFC600).withOpacity(0.5),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  styles[index].title,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF222222) : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
