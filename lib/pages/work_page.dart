import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import 'report_page.dart';
import 'work_image_detail_page.dart';
import 'message_page.dart';
import 'video_call_page.dart';
import 'video_detail_page.dart';
import '../utils/preference_helper.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({
    super.key,
    required this.character,
  });

  final Map<String, dynamic> character;

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  bool _isLiked = false;
  bool _isFavorited = false;
  int _currentLikeNum = 0;
  int _currentFollowNum = 0;

  @override
  void initState() {
    super.initState();
    _currentLikeNum = widget.character['SugerShowLike'] as int;
    _currentFollowNum = widget.character['SugerShowFollowNum'] as int;
    _loadSavedStates();
  }

  Future<void> _loadSavedStates() async {
    final String nickName = widget.character['SugerNickName'] as String;
    final bool liked = await PreferenceHelper.isLiked(nickName);
    final bool favorited = await PreferenceHelper.isFavorited(nickName);
    
    final int baseLikeNum = widget.character['SugerShowLike'] as int;
    final int baseFollowNum = widget.character['SugerShowFollowNum'] as int;
    
    setState(() {
      _isLiked = liked;
      _isFavorited = favorited;
      
      // 根据保存的状态调整数字
      _currentLikeNum = baseLikeNum;
      _currentFollowNum = baseFollowNum;
      
      if (liked) {
        _currentLikeNum += 1;
        _currentFollowNum += 1;
      }
      if (favorited) {
        _currentFollowNum += 1;
      }
    });
  }

  void _toggleLike() async {
    final String nickName = widget.character['SugerNickName'] as String;
    final bool wasLiked = _isLiked;
    
    setState(() {
      _isLiked = !_isLiked;
      
      if (_isLiked && !wasLiked) {
        // 点赞：增加喜欢数和粉丝数
        _currentLikeNum += 1;
        _currentFollowNum += 1;
      } else if (!_isLiked && wasLiked) {
        // 取消点赞：减少喜欢数和粉丝数
        _currentLikeNum -= 1;
        _currentFollowNum -= 1;
      }
    });
    
    // 保存状态到本地
    await PreferenceHelper.setLiked(nickName, _isLiked);
  }

  void _toggleFavorite() async {
    final String nickName = widget.character['SugerNickName'] as String;
    final bool wasFavorited = _isFavorited;
    
    setState(() {
      _isFavorited = !_isFavorited;
      
      if (_isFavorited && !wasFavorited) {
        // 收藏：增加粉丝数
        _currentFollowNum += 1;
      } else if (!_isFavorited && wasFavorited) {
        // 取消收藏：减少粉丝数
        _currentFollowNum -= 1;
      }
    });
    
    // 保存状态到本地
    await PreferenceHelper.setFavorited(nickName, _isFavorited);
  }

  Map<String, dynamic> _getUpdatedCharacter() {
    final updatedCharacter = Map<String, dynamic>.from(widget.character);
    updatedCharacter['SugerShowLike'] = _currentLikeNum;
    updatedCharacter['SugerShowFollowNum'] = _currentFollowNum;
    return updatedCharacter;
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ReportPage(
                    character: widget.character,
                  ),
                ),
              );
            },
            child: const Text(
              'Report',
              style: TextStyle(
                color: Color(0xFF007AFF),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop({'action': 'block', 'character': widget.character});
            },
            isDestructiveAction: true,
            child: const Text(
              'Block',
              style: TextStyle(
                color: Color(0xFFFF3B30),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop({'action': 'mute', 'character': widget.character});
            },
            isDestructiveAction: true,
            child: const Text(
              'Mute',
              style: TextStyle(
                color: Color(0xFFFF3B30),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xFF007AFF),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final String userIcon = widget.character['SugerUserIcon'] as String;
    final String nickName = widget.character['SugerNickName'] as String;
    final List<dynamic> photoArray =
        widget.character['SugerShowPhotoArray'] as List<dynamic>;
    final String motto = widget.character['SugerShowMotto'] as String;
    final String? videoPath = widget.character['SugerShowVideo'] as String?;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop({
          'action': 'update',
          'character': _getUpdatedCharacter(),
        });
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/bg_home_nor.webp',
                width: screenWidth,
                height: screenHeight,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
            child: Column(
              children: [
                _AppBar(
                  onBack: () {
                    Navigator.of(context).pop({
                      'action': 'update',
                      'character': _getUpdatedCharacter(),
                    });
                  },
                  onInfo: () => _showActionSheet(context),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _ProfileHeader(
                          userIcon: userIcon,
                          nickName: nickName,
                          followNum: _currentFollowNum,
                          likeNum: _currentLikeNum,
                          isLiked: _isLiked,
                          isFavorited: _isFavorited,
                        ),
                        const SizedBox(height: 24),
                        _MottoSection(motto: motto),
                        const SizedBox(height: 24),
                        _ActionButtonsRow(
                          character: widget.character,
                        ),
                        if (videoPath != null) ...[
                          const SizedBox(height: 24),
                          _VideoSection(
                            videoPath: videoPath,
                            screenWidth: screenWidth,
                            character: widget.character,
                          ),
                        ],
                        const SizedBox(height: 24),
                        _PhotoGallery(
                          photoArray: photoArray,
                          screenWidth: screenWidth,
                          characterName: nickName,
                        ),
                        const SizedBox(height: 24),
                        _ActionButtons(
                          isLiked: _isLiked,
                          isFavorited: _isFavorited,
                          onLike: _toggleLike,
                          onFavorite: _toggleFavorite,
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.onBack,
    required this.onInfo,
  });

  final VoidCallback onBack;
  final VoidCallback onInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Color(0xFF222222),
              ),
            ),
          ),
          GestureDetector(
            onTap: onInfo,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.info_outline,
                size: 20,
                color: Color(0xFF222222),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.userIcon,
    required this.nickName,
    required this.followNum,
    required this.likeNum,
    required this.isLiked,
    required this.isFavorited,
  });

  final String userIcon;
  final String nickName;
  final int followNum;
  final int likeNum;
  final bool isLiked;
  final bool isFavorited;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              userIcon,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nickName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF1D1D1D),
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _StatItem(
                    icon: isFavorited ? Icons.favorite : Icons.favorite_outline,
                    count: followNum,
                    label: 'Followers',
                    isHighlighted: isFavorited,
                  ),
                  const SizedBox(width: 20),
                  _StatItem(
                    icon: isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    count: likeNum,
                    label: 'Likes',
                    isHighlighted: isLiked,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.count,
    required this.label,
    this.isHighlighted = false,
  });

  final IconData icon;
  final int count;
  final String label;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isHighlighted
              ? const Color(0xFFFFC600)
              : const Color(0xFF666666),
        ),
        const SizedBox(width: 4),
        Text(
          '$count',
          style: const TextStyle(
            color: Color(0xFF1D1D1D),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF999999),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _MottoSection extends StatelessWidget {
  const _MottoSection({
    required this.motto,
  });

  final String motto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC600),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Motto',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF1D1D1D),
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            motto,
            style: const TextStyle(
              color: Color(0xFF4A4A4A),
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  const _ActionButtonsRow({
    required this.character,
  });

  final Map<String, dynamic> character;

  @override
  Widget build(BuildContext context) {
    final String userIcon = character['SugerUserIcon'] as String;
    final String nickName = character['SugerNickName'] as String;
    final String sayhi = character['SugerShowSayhi'] as String;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => VideoCallPage(
                    character: character,
                    userIcon: userIcon,
                    nickName: nickName,
                  ),
                ),
              );
            },
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.videocam_outlined,
                    size: 20,
                    color: const Color(0xFF666666),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Video Call',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MessagePage(
                    character: character,
                    userIcon: userIcon,
                    nickName: nickName,
                    greeting: sayhi,
                  ),
                ),
              );
            },
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFFFC600),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFC600).withOpacity(0.4),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message_outlined,
                    size: 20,
                    color: Color(0xFF222222),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Message',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PhotoGallery extends StatelessWidget {
  const _PhotoGallery({
    required this.photoArray,
    required this.screenWidth,
    required this.characterName,
  });

  final List<dynamic> photoArray;
  final double screenWidth;
  final String characterName;

  @override
  Widget build(BuildContext context) {
    if (photoArray.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Works',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF1D1D1D),
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photoArray.length,
            itemBuilder: (context, index) {
              final String photoUrl = photoArray[index] as String;
              return Padding(
                padding: EdgeInsets.only(
                  right: index == photoArray.length - 1 ? 0 : 16,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => WorkImageDetailPage(
                          photoArray: photoArray,
                          initialIndex: index,
                          characterName: characterName,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 180,
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        photoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.isLiked,
    required this.isFavorited,
    required this.onLike,
    required this.onFavorite,
  });

  final bool isLiked;
  final bool isFavorited;
  final VoidCallback onLike;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onLike,
          child: Container(
            width: 120,
            height: 48,
            decoration: BoxDecoration(
              color: isLiked ? const Color(0xFFFFC600) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isLiked ? const Color(0xFFFFC600) : const Color(0xFFE0E0E0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  size: 20,
                  color: isLiked ? const Color(0xFF222222) : const Color(0xFF666666),
                ),
                const SizedBox(width: 6),
                Text(
                  isLiked ? 'Liked' : 'Like',
                  style: TextStyle(
                    color: isLiked ? const Color(0xFF222222) : const Color(0xFF666666),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onFavorite,
          child: Container(
            width: 120,
            height: 48,
            decoration: BoxDecoration(
              color: isFavorited ? const Color(0xFFFFC600) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isFavorited ? const Color(0xFFFFC600) : const Color(0xFFE0E0E0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                  size: 20,
                  color: isFavorited ? const Color(0xFF222222) : const Color(0xFF666666),
                ),
                const SizedBox(width: 6),
                Text(
                  isFavorited ? 'Saved' : 'Save',
                  style: TextStyle(
                    color: isFavorited ? const Color(0xFF222222) : const Color(0xFF666666),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _VideoSection extends StatefulWidget {
  const _VideoSection({
    required this.videoPath,
    required this.screenWidth,
    required this.character,
  });

  final String videoPath;
  final double screenWidth;
  final Map<String, dynamic> character;

  @override
  State<_VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<_VideoSection> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset(widget.videoPath);
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isLoading = false;
          _isPlaying = _controller!.value.isPlaying;
        });
        _controller!.setLooping(true);
        _controller!.addListener(_videoListener);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _videoListener() {
    if (_controller != null && mounted) {
      setState(() {
        _isPlaying = _controller!.value.isPlaying;
      });
    }
  }


  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Video',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF1D1D1D),
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () async {
            _controller?.pause();
            if (!mounted) return;
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => VideoDetailPage(
                  character: widget.character,
                  videoPath: widget.videoPath,
                ),
              ),
            );
            
            if (!mounted) return;
            if (result != null && result is Map) {
              final String action = result['action'] as String;
              final Map<String, dynamic> char = result['character'] as Map<String, dynamic>;
              
              if (action == 'block' || action == 'mute') {
                Navigator.of(context).popUntil((route) => route.isFirst);
                if (mounted && Navigator.of(context).canPop()) {
                  Navigator.of(context).pop({
                    'action': action,
                    'character': char,
                  });
                }
              } else if (action == 'update') {
                if (mounted) {
                  Navigator.of(context).pop({
                    'action': 'update',
                    'character': char,
                  });
                }
              }
            }
          },
          child: Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_isLoading)
                    Container(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFFC600),
                        ),
                      ),
                    )
                  else if (_isInitialized && _controller != null)
                    AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    )
                  else
                    Container(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ),
                  if (_isInitialized)
                    IgnorePointer(
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

