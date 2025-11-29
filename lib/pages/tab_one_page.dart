import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'work_page.dart';

class TabOnePage extends StatefulWidget {
  const TabOnePage({super.key});

  @override
  State<TabOnePage> createState() => _TabOnePageState();
}

class _TabOnePageState extends State<TabOnePage> {
  int _selectedTab = 0;
  List<Map<String, dynamic>> _characters = [];
  Set<int> _followedIndices = {};
  Set<String> _blockedNickNames = {};
  Set<String> _mutedNickNames = {};

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  void _toggleFollow(int index) {
    setState(() {
      if (_followedIndices.contains(index)) {
        _followedIndices.remove(index);
      } else {
        _followedIndices.add(index);
      }
    });
  }

  List<Map<String, dynamic>> get _displayedCharacters {
    List<Map<String, dynamic>> filtered = _characters.where((character) {
      final String nickName = character['SugerNickName'] as String;
      return !_blockedNickNames.contains(nickName) &&
          !_mutedNickNames.contains(nickName);
    }).toList();

    if (_selectedTab == 1) {
      return filtered
          .asMap()
          .entries
          .where((entry) {
            final int originalIndex = _characters.indexOf(entry.value);
            return _followedIndices.contains(originalIndex);
          })
          .map((entry) => entry.value)
          .toList();
    }
    return filtered;
  }

  Future<void> _loadCharacters() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/suger_characters.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);
      setState(() {
        _characters = jsonData.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonWidth = (screenWidth - 40) / 2.0;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg_home_nor.webp',
              width: screenWidth,
              height: MediaQuery.of(context).size.height,
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
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/img_home_artist.webp',
                      width: screenWidth - 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTab = 0;
                            });
                          },
                          child: Container(
                            width: buttonWidth,
                            height: 60,
                            decoration: BoxDecoration(
                              color: _selectedTab == 0
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFFF0F0F0),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Center(
                               child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Image.asset(
                                _selectedTab == 0
                                    ? 'assets/recommend_nor.webp'
                                    : 'assets/recommend_pre.webp',
                                fit: BoxFit.contain,
                              ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTab = 1;
                            });
                          },
                          child: Container(
                            width: buttonWidth,
                            height: 60,
                            decoration: BoxDecoration(
                              color: _selectedTab == 1
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFFF0F0F0),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 50),
                                child: Image.asset(
                                  _selectedTab == 1
                                      ? 'assets/follow_nor.webp'
                                      : 'assets/follow_pre.webp',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: 20,
                        right: 20,
                        bottom: MediaQuery.of(context).padding.bottom + 130,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: _characters.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : _displayedCharacters.isEmpty && _selectedTab == 1
                                ? const Center(
                                    child: Text(
                                      'No followed characters yet',
                                      style: TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                : GridView.builder(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 16,
                                    ),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 11,
                                      childAspectRatio: ((screenWidth - 40) - 24 - 11) /
                                          2 /
                                          234,
                                    ),
                                    itemCount: _displayedCharacters.length,
                                    itemBuilder: (context, index) {
                                      final character = _displayedCharacters[index];
                                      final int originalIndex = _characters.indexOf(character);
                                      return _CharacterCard(
                                        character: character,
                                        originalIndex: originalIndex,
                                        isFollowed: _followedIndices.contains(originalIndex),
                                        onTap: () async {
                                          final result = await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => WorkPage(
                                                character: character,
                                              ),
                                            ),
                                          );
                                          
                                          if (result != null && result is Map) {
                                            final String action = result['action'] as String;
                                            final Map<String, dynamic> char = result['character'] as Map<String, dynamic>;
                                            final String nickName = char['SugerNickName'] as String;
                                            
                                            setState(() {
                                              if (action == 'block') {
                                                _blockedNickNames.add(nickName);
                                                // Reload data to refresh the list
                                                _loadCharacters();
                                              } else if (action == 'mute') {
                                                _mutedNickNames.add(nickName);
                                                // Reload data to refresh the list
                                                _loadCharacters();
                                              } else if (action == 'update') {
                                                // 更新对应角色的数据
                                                final int index = _characters.indexWhere(
                                                  (c) => c['SugerNickName'] == nickName,
                                                );
                                                if (index != -1) {
                                                  _characters[index] = char;
                                                }
                                              }
                                            });
                                          }
                                        },
                                      );
                                    },
                                  ),
                      ),
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

class _CharacterCard extends StatelessWidget {
  const _CharacterCard({
    required this.character,
    required this.originalIndex,
    required this.isFollowed,
    required this.onTap,
  });

  final Map<String, dynamic> character;
  final int originalIndex;
  final bool isFollowed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> photoArray =
        character['SugerShowPhotoArray'] as List<dynamic>;
    final String photoUrl = photoArray.isNotEmpty
        ? photoArray[0] as String
        : 'assets/header_1_work_1.png';

    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = constraints.maxWidth;
        final String userIcon = character['SugerUserIcon'] as String;
        final String nickName = character['SugerNickName'] as String;
        
        return GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/img_home_header.webp',
                    width: cardWidth,
                    height: 54,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            userIcon,
                            width: 22,
                            height: 22,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          nickName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: cardWidth,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    photoUrl,
                    width: cardWidth,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}